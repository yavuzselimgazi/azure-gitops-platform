resource "azuread_application" "github_actions" {
  display_name = "github-actions-azure-gitops-platform"
}

resource "azuread_service_principal" "github_actions" {
  client_id = azuread_application.github_actions.client_id
}

resource "azuread_application_federated_identity_credential" "github" {
  application_id = azuread_application.github_actions.id
  display_name   = "github-federated-credential"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:yavuzselimgazi@308671432/azure-gitops-platform@1333438916:ref:refs/heads/main"
}

resource "azurerm_role_assignment" "github_actions_acr_push" {
  principal_id                    = azuread_service_principal.github_actions.object_id
  role_definition_name            = "AcrPush"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}