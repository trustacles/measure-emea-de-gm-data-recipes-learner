FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir dbt-core dbt-bigquery

# Not tied to any single dbt project — DBT_SOURCE_PATH is a build-time
# argument. Passing "dbt_projects" (the whole container folder) copies
# every dbt project into the image at once. Matches your real repo's
# Dockerfile exactly: same ARG, same COPY structure.
ARG DBT_SOURCE_PATH
COPY ${DBT_SOURCE_PATH}/ profiles.yml ./

# DBT_PROFILES_DIR is genuinely required here — dbt's default lookup
# location is ~/.dbt, but profiles.yml just landed at /app instead, so
# something has to point dbt there. No equivalent default exists anywhere
# else, so this stays.
ENV DBT_PROFILES_DIR=/app

# No ENV DBT_TARGET here — matching the real Dockerfile, which doesn't
# set it either. profiles.yml's own line already provides this exact
# fallback: target: "{{ env_var('DBT_TARGET', 'cloud_run_job_automation') }}"
# — so if DBT_TARGET is never set anywhere, it still resolves to
# cloud_run_job_automation on its own. Setting it again here would just
# be restating a default that already lives in profiles.yml, risking the
# two drifting out of sync if one changes without the other.

# No DBT_PROJECT_DIR default here — matching the real Dockerfile exactly,
# which has zero project-specific references anywhere. This means every
# deployment/run MUST supply it explicitly (Part 10's --set-env-vars
# already does this for every example). entrypoint.sh below fails loudly
# with a clear message if it's ever missing, instead of silently
# defaulting to one project.

# As we're not running a service but a job, there's no need for a
# healthcheck — matches your real repo's Dockerfile exactly
HEALTHCHECK NONE

# entrypoint.sh requires $DBT_PROJECT_DIR to be set at container start and
# passes it to dbt, so the SAME image can run any project just by setting
# that one env var — no default baked in, so nothing here ever silently
# points at "my_dbt_project" specifically
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]