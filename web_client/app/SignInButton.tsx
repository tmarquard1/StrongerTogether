"use client";

import { signIn, useSession } from "next-auth/react";

export default function SignInButton() {
  const { data: session } = useSession();

  const handleSignIn = async () => {
    try {
      const result = await signIn("google"); // Initiates the Google login flow via NextAuth
      if (!result?.ok) {
        console.error("Sign-in failed:", result?.error);
        alert("Sign-in failed. Please try again.");
      } else {
        console.log("Access Token:", session?.user.accessToken); // Log the accessToken
      }
    } catch (error) {
      console.error("An error occurred during sign-in:", error);
      alert("An unexpected error occurred. Please try again later.");
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