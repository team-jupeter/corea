defmodule Corea.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Inspect, except: [:password]}
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime

    field :type, :string
    field :name, :string
    field :birth_date, :naive_datetime
    field :ssn, :string #? social security number
    field :address, :string
    field :gps, {:array, :map}
    field :nationality, :string
    field :username, :string
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true
    field :auth_code, :string #? Social Security Number
    field :supul_code, :string
    field :supul_name, :string
    field :family_code, :string, default: nil
    field :married, :boolean, default: false
    field :default_family, :boolean, default: false
    field :default_entity_id, :binary_id
    field :default_entity_name, :string
    field :default_currency, :string



    has_many :certificates, Corea.Certificates.Certificate
    has_one :health_report, Corea.CDC.HealthReport
    has_one :student, Corea.Schools.Student
    has_one :mentor, Corea.Schools.Mentor
    has_many :weddings, Corea.Weddings.Wedding

    belongs_to :family, Corea.Families.Family, on_replace: :nilify
    belongs_to :supul, Corea.Supuls.Supul, on_replace: :nilify
    belongs_to :nation, Corea.Nations.Nation, type: :binary_id, on_replace: :nilify
    belongs_to :constitution,  Corea.Votes.Constitution, type: :binary_id, on_replace: :nilify

    many_to_many(
      :entities,
      Entity,
      join_through: "users_entities",
      on_replace: :delete
    )

    many_to_many(
      :schools,
      School,
      join_through: "schools_students",
      on_replace: :delete
    )

    timestamps()
  end

  @fields [
    :name, :type, :nationality, :email, :birth_date, :ssn, :default_entity_name,
    :password, :nation_id, :auth_code, :supul_name, :address, :family_code,
    :constitution_id, :supul_code, :username, :default_entity_id, :supul_id,
    :married, :default_family, :default_currency
  ]

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.
  """
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Corea.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 80)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> prepare_changes(&hash_password/1)
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    changeset
    |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.
  """
  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password()
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%Corea.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
