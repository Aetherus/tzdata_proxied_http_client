defmodule TzdataProxiedHttpClient do
  @moduledoc """
  An HTTP client that supports proxies for Tzdata to poll IANA timezone database.
  """

  def get(url, headers, _opts) do
    client()
    |> Tesla.get(url, headers: headers)
    |> then(&transform_get_response/1)
  end

  def head(url, headers, _opts) do
    client()
    |> Tesla.get(url, headers: headers)
    |> then(&transform_head_response/1)
  end

  defp transform_get_response({:ok, %Tesla.Env{status: status, headers: headers, body: body}}) do
    {:ok, {status, headers, body}}
  end

  defp transform_get_response({:error, _} = error), do: error

  defp transform_head_response({:ok, %Tesla.Env{status: status, headers: headers}}) do
    {:ok, {status, headers}}
  end

  defp transform_head_response({:error, _} = error), do: error

  defp client do
    Tesla.client(
      _middleware = [
        Tesla.Middleware.FollowRedirects
      ],
      _adapter = {
        Tesla.Adapter.Mint,
        proxy: Application.fetch_env!(:tzdata_proxied_http_client, :proxy)
      }
    )
  end
end
