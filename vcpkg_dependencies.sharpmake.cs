using Sharpmake;
using System;

[module: Sharpmake.Include("csharpmake/vcpkg_dependencies_base.sharpmake.cs")]

// Generated
namespace lu
{
	[Sharpmake.Export]
	public class vcpkg_workspace_project : vcpkg_project
	{
		public override void ConfigureRelease(Project.Configuration conf, Target target)
		{
			base.ConfigureRelease(conf, target);
		}

		public override void ConfigureDebug(Project.Configuration conf, Target target)
		{
			base.ConfigureDebug(conf, target);
		}
	}

	//[Sharpmake.Export]
	//public class {{project_name}}_vcpkg : vcpkg_workspace_project
	//{
    //    public override void ConfigureRelease(Project.Configuration conf, Target target)
	//	{
	//		base.ConfigureRelease(conf, target);
	//		
	//		conf.LibraryFiles.Add(
	//			{{project_debug_libraries}});
	//	}
	//
    //    public override void ConfigureDebug(Project.Configuration conf, Target target)
	//	{
	//		base.ConfigureDebug(conf, target);
	//		
	//		conf.LibraryFiles.Add(
	//			{{project_release_libraries}});
	//	}
	//	
    //    public static void AddToSolution(Solution.Configuration conf, lu.Target target)
    //    {
    //        conf.AddProject<{{project_name}}_vcpkg>(target, false, "{{project_name}}");
    //    }
    //}
}

