import NextAuth, { SessionStrategy } from "next-auth";
import KeycloakProvider from "next-auth/providers/keycloak";

export const authOptions = {
  providers: [
    KeycloakProvider({
      clientId: process.env.KEYCLOAK_CLIENT_ID || "talon-client",
      clientSecret: process.env.KEYCLOAK_CLIENT_SECRET || "talon-secret",
      issuer: process.env.KEYCLOAK_ISSUER || "http://localhost:8080/realms/talon", // Ensure this points to the correct Keycloak domain
      authorization: {
        params: {
          scope: "openid profile email", // Ensure the required scopes are included
        },
      },
    }),
  ],
  secret: process.env.NEXTAUTH_SECRET || "talon-nextauth-secret",
  session: {
    strategy: "jwt" as SessionStrategy, // Use JWT for session handling
  },
};

// Ensure NextAuth is exported as the default function
export default NextAuth(authOptions);
