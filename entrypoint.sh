#!/bin/sh
if [ -z "$DBT_PROJECT_DIR" ]; then
  echo "ERROR: DBT_PROJECT_DIR is not set. This image is not tied to any" >&2
  echo "single dbt project — you must supply it explicitly, e.g.:" >&2
  echo "  docker run --env DBT_PROJECT_DIR=/app/<your_project_name> ..." >&2
  echo "  --set-env-vars=\"DBT_PROJECT_DIR=/app/<your_project_name>\" (Cloud Run)" >&2
  exit 1
fi
exec dbt "$@" --project-dir "$DBT_PROJECT_DIR" --profiles-dir "$DBT_PROFILES_DIR"