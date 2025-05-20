// OIDC utility for Keycloak PKCE auth
import { UserManager, WebStorageStateStore, UserManagerSettings } from "oidc-client-ts";

export const oidcConfig: UserManagerSettings = {
  authority: "http://localhost:8080/realms/talon",
  client_id: "talon",
  redirect_uri: typeof window !== "undefined" ? window.location.origin + "/auth/callback" : "",
  response_type: "code",
  scope: "openid profile email",
  post_logout_redirect_uri: typeof window !== "undefined" ? window.location.origin : "",
  userStore: typeof window !== "undefined" ? new WebStorageStateStore({ store: window.localStorage }) : undefined,
};

export function getUserManager() {
  if (typeof window === "undefined") return undefined;
  return new UserManager(oidcConfig);
}
