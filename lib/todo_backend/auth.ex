defmodule TodoBackend.Auth do
  use Joken.Config

  def token_config do
    default_claims(iss: "todo_backend", aud: "todo_backend", default_exp: 3600)
  end

  def signer do
    secret_key = System.get_env("JWT_SECRET_KEY")
    Joken.Signer.create("HS256", secret_key)
  end

  def generate_token(user) do
    extra_claims = %{
      "user_id" => user.id,
      "email" => user.email
    }

    {:ok, token, _claims} = generate_and_sign(extra_claims, signer())
    token
  end

  def verify_token(token) do
    case verify_and_validate(token, signer()) do
      {:ok, claims} -> {:ok, claims}
      {:error, reason} -> {:error, reason}
    end
  end
end
