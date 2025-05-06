import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  output: 'export', // Enables static export
  trailingSlash: true, // Ensures all paths end with a slash (important for S3)
};

export default nextConfig;
