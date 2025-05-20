"use client";

import { UserManager, WebStorageStateStore } from "oidc-client-ts";
import { getUserManager } from "./utils/oidc";

const oidcConfig = {
  authority: "http://localhost:8080/realms/talon", // Keycloak base URL for your realm
  client_id: "talon",
  redirect_uri: typeof window !== "undefined" ? window.location.origin + "/auth/callback" : "",
  response_type: "code",
  scope: "openid profile email",
  post_logout_redirect_uri: typeof window !== "undefined" ? window.location.origin : "",
  // Always set userStore to localStorage, only on client
  userStore: typeof window !== "undefined" ? new WebStorageStateStore({ store: window.localStorage }) : undefined,
};

export default function SignInButton() {

  const handleSignIn = async () => {
    const userManager = getUserManager();
    if (userManager) {
      await userManager.signinRedirect();
    }
  };

  return (
    <button
      onClick={handleSignIn}
      className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
    >
      Sign In
    </button>
  );
}