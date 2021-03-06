defmodule Corea.CDC.HealthReport do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "health_reports" do
    field :blood_pressure, :decimal
    field :blood_type, :decimal
    field :case_history, :decimal
    field :cholesterol, :decimal
    field :disabled, :decimal
    field :disease, :decimal
    field :dna, :decimal
    field :fingerprints, {:array, :map}
    field :face, :decimal
    field :height, :decimal
    field :infection, :boolean, default: false
    field :iris, :decimal
    field :liver_test, :decimal
    field :vision, :decimal
    field :weight, :decimal
    field :digital_certificate, :string

    has_many :diagnoses, Corea.CDC.Diagnosis
    has_many :prescriptions, Corea.CDC.Prescription
    belongs_to :user, Corea.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(health_sheet, attrs) do
    health_sheet
    |> cast(attrs, [:weight, :height, :infection, :fingerprint, :iris, :blood_pressure, :disease, :dna, :blood_type, :vision, :liver_test, :disabled, :cholesterol, :case_history])
    |> validate_required([:infection])
  end
end
