brew install pre-commit



Create a .pre-commit-config.yaml file:


repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.77.0
    hooks:
      - id: terraform_fmt
      - id: terraform_tflint
      - id: terraform_tfsec

pre-commit install



name: Terraform Lint and Security Checks

on:
  pull_request:
    branches:
      - main

jobs:
  lint-and-security:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.0

      - name: Run terraform fmt
        run: terraform fmt -check -recursive

      - name: Run TFLint
        run: tflint

      - name: Run tfsec
        run: tfsec .