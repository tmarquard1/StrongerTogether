"use client";

import { useRouter } from "next/navigation";

export default function SignInButton() {
  const router = useRouter();

  const handleSignIn = () => {
    router.push("http://www.strava.com/oauth/authorize?client_id=156846&response_type=code&redirect_uri=http://localhost:8000/callback&approval_prompt=force&scope=read,profile:read_all,activity:read,activity:write");
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