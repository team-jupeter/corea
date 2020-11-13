defmodule Corea.CertificatesTest do
  use Corea.DataCase

  alias Corea.Certificates

  describe "certificates" do
    alias Corea.Certificates.Certificate

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def certificate_fixture(attrs \\ %{}) do
      {:ok, certificate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Certificates.create_certificate()

      certificate
    end

    test "list_certificates/0 returns all certificates" do
      certificate = certificate_fixture()
      assert Certificates.list_certificates() == [certificate]
    end

    test "get_certificate!/1 returns the certificate with given id" do
      certificate = certificate_fixture()
      assert Certificates.get_certificate!(certificate.id) == certificate
    end

    test "create_certificate/1 with valid data creates a certificate" do
      assert {:ok, %Certificate{} = certificate} = Certificates.create_certificate(@valid_attrs)
      assert certificate.title == "some title"
    end

    test "create_certificate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Certificates.create_certificate(@invalid_attrs)
    end

    test "update_certificate/2 with valid data updates the certificate" do
      certificate = certificate_fixture()
      assert {:ok, %Certificate{} = certificate} = Certificates.update_certificate(certificate, @update_attrs)
      assert certificate.title == "some updated title"
    end

    test "update_certificate/2 with invalid data returns error changeset" do
      certificate = certificate_fixture()
      assert {:error, %Ecto.Changeset{}} = Certificates.update_certificate(certificate, @invalid_attrs)
      assert certificate == Certificates.get_certificate!(certificate.id)
    end

    test "delete_certificate/1 deletes the certificate" do
      certificate = certificate_fixture()
      assert {:ok, %Certificate{}} = Certificates.delete_certificate(certificate)
      assert_raise Ecto.NoResultsError, fn -> Certificates.get_certificate!(certificate.id) end
    end

    test "change_certificate/1 returns a certificate changeset" do
      certificate = certificate_fixture()
      assert %Ecto.Changeset{} = Certificates.change_certificate(certificate)
    end
  end
end
