import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import SignInButton from "./SignInButton";
import Link from "next/link";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "StrongerTogether",
  description: "Welcome to StrongerTogether",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <header className="flex justify-between items-center p-4 bg-gray-100 shadow-md">
          <h1 className="text-xl font-bold text-green-700">
            <Link href="/">StrongerTogether</Link>
          </h1>
          <div className="flex items-center gap-4">
            <Link href="/create-event">
              <button className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
                Create Event
              </button>
            </Link>
            <SignInButton />
          </div>
        </header>
        {children}
      </body>
    </html>
  );
}
