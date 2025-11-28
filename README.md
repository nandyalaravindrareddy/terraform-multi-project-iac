TFE-ready Terraform repo (single main.tf, multi-project via workspace variable)

Overview
- Single repository and single main.tf.
- Each Terraform Enterprise (TFE) workspace sets the terraform variable:
    run_project = "project1"  or "project2"
- TFE provides isolated state per workspace; no backend switching needed.
- All resources are deployed into the same GCP project: custom-plating-475002-j7
- Modules are instantiated using for_each keyed by run_project so resource addresses are unique:
    module.gcs["project1"], module.iam["project1"], etc.

How to use (TFE / Terraform Cloud)
1. Create workspace `project1` in TFE and point to this repo.
2. In workspace variables add a Terraform variable:
     Key: run_project
     Value: project1
3. In workspace variables add an Environment variable (sensitive):
     Key: GOOGLE_CREDENTIALS
     Value: <paste service account JSON>
4. (Optional) Add variable project_id if you prefer overriding provider project.
5. Commit changes to repo → TFE will queue a run for the workspace and apply using workspace-scoped state.

Local testing (not recommended for production):
- Export credentials:
    export GOOGLE_APPLICATION_CREDENTIALS="/path/to/key.json"
- Run plan:
    terraform init
    terraform plan -var="run_project=project1"

Notes
- The code expects per-project locals under locals/<project>/*.json.
- All resources default to GCP project 'custom-plating-475002-j7' as requested.
