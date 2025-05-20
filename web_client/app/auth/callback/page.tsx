"use client";
import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { getUserManager } from "../../utils/oidc";

export default function CallbackPage() {
  const router = useRouter();

  useEffect(() => {
    const userManager = getUserManager();
    if (!userManager) return;
    userManager.signinCallback().then(user => {
      // Store tokens or user info as needed
      router.replace("/");
    }).catch(err => {
      console.error("OIDC callback error", err);
    });
  }, [router]);

  return <div>Signing you in...</div>;
}
