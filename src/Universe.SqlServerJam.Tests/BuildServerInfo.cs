using System;

namespace Universe.SqlServerJam.Tests;

public static class BuildServerInfo
{
    public static bool IsBuildServer => BuildServerKey != null;
    public static string BuildServerKey
    {
        get
        {
            var names = new[]
            {
                "APPVEYOR",
                "bamboo_planKey",
                "BITBUCKET_COMMIT",
                "BITRISE_IO",
                "BUDDY_WORKSPACE_ID",
                "BUILDKITE",
                "CIRCLECI",
                "CIRRUS_CI",
                "CODEBUILD_BUILD_ARN",
                "DRONE",
                "DSARI",
                "GITHUB_ACTIONS",
                "GITLAB_CI",
                "GO_PIPELINE_LABEL",
                "HUDSON_URL",
                "MAGNUM",
                "SAILCI",
                "SEMAPHORE",
                "SHIPPABLE",
                "TDDIUM",
                "STRIDER",
                "TDDIUM",
                "TEAMCITY_VERSION",
                "TF_BUILD",
                "TRAVIS"
            };
            foreach (var name in names)
            {
                var raw = Environment.GetEnvironmentVariable(name);
                if (raw != null && !"False".Equals(raw, StringComparison.OrdinalIgnoreCase))
                    return name;
            }

            return null;
        }
    }
}