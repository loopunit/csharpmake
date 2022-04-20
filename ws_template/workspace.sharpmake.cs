using Sharpmake;

[module: Sharpmake.Include("common.sharpmake.cs")]
[module: Sharpmake.Include("vcpkg_dependencies.sharpmake.cs")]
//[module: Sharpmake.Include("organization/project/project.sharpmake.cs")]

[Generate]
public class sharpmake_workspace_solution : lu.common_solution
{
    public sharpmake_workspace_solution()
    {
        Name = "sharpmake_workspace";
        AddDefaultTargets();
    }

    public override void ConfigureAll(Solution.Configuration conf, lu.Target target)
    {
        base.ConfigureAll(conf, target);

        //organization.project_Project.AddToSolution(conf, target);
    }
}
public static class Main
{
    [Sharpmake.Main]
    public static void SharpmakeMain(Sharpmake.Arguments arguments)
    {
        arguments.Generate<sharpmake_workspace_solution>();
    }
}
