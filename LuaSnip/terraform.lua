return {
  s({ trig = "dp_service" },
    fmt(
      [[
        module "deployment_pipeline" {{
          source       = "git::https://gitlab.com/kloverhq/terraform/modules/gke-deployment-pipeline?ref=v0.0.22"
          domain       = var.domain
          service_name = var.service_name
        }}
      ]],
      {}
    )
  ),
  s({ trig = "dp_cron_job" },
    fmt(
      [[
        module "deployment_pipeline" {{
          source   = "git::https://gitlab.com/kloverhq/terraform/modules/gke-cronjob-pipeline?ref=v0.0.4"
          domain   = var.domain
          job_name = var.job_name
        }}
      ]],
      {}
    )
  ),
  s({ trig = "service_account" },
    fmt(
      [[
        # {{ google_service_account_email }}
        module "gcp_service_account" {{
          source                   = "git::https://gitlab.com/kloverhq/terraform/modules/gcp-service-account//k8s-link?ref=k8s-link-v0.0.5"
          bigquery_access_required = {}
          domain                   = var.domain
          service_name             = var.service_name
        }}
      ]],
      {
        i(1, "true"),
      }
    )
  ),
  s({ trig = "spanner_db" },
    fmt(
      [[
        module "spanner_db" {{
          source      = "git::https://gitlab.com/kloverhq/terraform/modules/spanner//database?ref=database-v0.0.1"
          environment = var.environment
          name        = "{}"
          permissions = [{{
            email = module.gcp_service_account.google_service_account_email
            role  = "READ_WRITE"
          }}]
        }}
      ]],
      {
        i(1, "my-spanner-db"),
      }
    )
  ),
  s({ trig = "bq-dataset" },
    fmt(
      [[
        module "bigquery_dataset" {{
          source = "git::https://gitlab.com/kloverhq/terraform/modules/bigquery//dataset?ref=dataset-v0.0.4"
          name   = "{}"
          permissions = [{{
            email  = module.gcp_service_account.google_service_account_email
            role   = "READ_WRITE"
            tables = ["*"]
          }}]
        }}
      ]],
      {
        i(1, "my-bigquery-dataset"),
      }
    )
  ),
  s({ trig = "kafka-account" },
    fmt(
      [[
        # {{ account_id, api_key: {{ id, secret }} }}
        module "confluent_service_account" {{
          source       = "git::https://gitlab.com/kloverhq/terraform/modules/confluent//service-account?ref=service-account-v0.0.1"
          environment  = var.environment
          domain       = var.domain
          service_name = var.service_name
        }}
      ]],
      {}
    )
  ),
  s({ trig = "kafka-topic" },
    fmt(
      [[
        module "confluent_topic" {{
          source           = "git::https://gitlab.com/kloverhq/terraform/modules/confluent//kafka-topic?ref=kafka-topic-v0.0.1"
          environment      = var.environment
          name             = "{}"
          partitions_count = {}
          permissions = [{{
            account_id = module.confluent_service_account.account_id
            role       = "WRITE"
          }}]
        }}
      ]],
      {
        i(1, "my-kafka-topic"),
        i(2, "6"),
      }
    )
  ),
  s({ trig = "secret" },
    fmt(
      [[
        module "{}" {{
          source       = "git::https://gitlab.com/kloverhq/terraform/modules/gcp-secret?ref=v0.0.1"
          domain       = var.domain
          service_name = var.service_name
          environment  = var.environment
          secret_name  = "{}"
          secret_value = module.{}
        }}
      ]],
      {
        i(1),
        f(function(arg)
          return { string.upper(arg[1][1]) }
        end, { 1 }),
        i(3, "terraform-resource.attr"),
      }
    )
  ),
}
