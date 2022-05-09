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

	// TODO: there doesn't seem to be any good way of generating this right now
	[Sharpmake.Export]
	public class boost_vcpkg : vcpkg_workspace_project
	{
        public override void ConfigureRelease(Project.Configuration conf, Target target)
		{
			base.ConfigureRelease(conf, target);
			
			conf.LibraryFiles.Add(
				"boost_atomic-vc140-mt.lib",
				"boost_chrono-vc140-mt.lib",
				"boost_container-vc140-mt.lib",
				"boost_context-vc140-mt.lib",
				"boost_contract-vc140-mt.lib",
				"boost_coroutine-vc140-mt.lib",
				"boost_date_time-vc140-mt.lib",
				"boost_exception-vc140-mt.lib",
				"boost_fiber-vc140-mt.lib",
				"boost_filesystem-vc140-mt.lib",
				"boost_graph-vc140-mt.lib",
				"boost_iostreams-vc140-mt.lib",
				"boost_json-vc140-mt.lib",
				"boost_locale-vc140-mt.lib",
				"boost_log-vc140-mt.lib",
				"boost_log_setup-vc140-mt.lib",
				"boost_math_c99-vc140-mt.lib",
				"boost_math_c99f-vc140-mt.lib",
				"boost_math_c99l-vc140-mt.lib",
				"boost_math_tr1-vc140-mt.lib",
				"boost_math_tr1f-vc140-mt.lib",
				"boost_math_tr1l-vc140-mt.lib",
				"boost_nowide-vc140-mt.lib",
				"boost_program_options-vc140-mt.lib",
				"boost_python310-vc140-mt.lib",
				"boost_random-vc140-mt.lib",
				"boost_regex-vc140-mt.lib",
				"boost_serialization-vc140-mt.lib",
				"boost_stacktrace_noop-vc140-mt.lib",
				"boost_stacktrace_windbg-vc140-mt.lib",
				"boost_stacktrace_windbg_cached-vc140-mt.lib",
				"boost_system-vc140-mt.lib",
				"boost_thread-vc140-mt.lib",
				"boost_timer-vc140-mt.lib",
				"boost_type_erasure-vc140-mt.lib",
				"boost_unit_test_framework-vc140-mt.lib",
				"boost_wave-vc140-mt.lib",
				"boost_wserialization-vc140-mt.lib");
		}
	
        public override void ConfigureDebug(Project.Configuration conf, Target target)
		{
			base.ConfigureDebug(conf, target);
			
			conf.LibraryFiles.Add(
				"boost_atomic-vc140-mt-gd.lib",
				"boost_chrono-vc140-mt-gd.lib",
				"boost_container-vc140-mt-gd.lib",
				"boost_context-vc140-mt-gd.lib",
				"boost_contract-vc140-mt-gd.lib",
				"boost_coroutine-vc140-mt-gd.lib",
				"boost_date_time-vc140-mt-gd.lib",
				"boost_exception-vc140-mt-gd.lib",
				"boost_fiber-vc140-mt-gd.lib",
				"boost_filesystem-vc140-mt-gd.lib",
				"boost_graph-vc140-mt-gd.lib",
				"boost_iostreams-vc140-mt-gd.lib",
				"boost_json-vc140-mt-gd.lib",
				"boost_locale-vc140-mt-gd.lib",
				"boost_log-vc140-mt-gd.lib",
				"boost_log_setup-vc140-mt-gd.lib",
				"boost_math_c99-vc140-mt-gd.lib",
				"boost_math_c99f-vc140-mt-gd.lib",
				"boost_math_c99l-vc140-mt-gd.lib",
				"boost_math_tr1-vc140-mt-gd.lib",
				"boost_math_tr1f-vc140-mt-gd.lib",
				"boost_math_tr1l-vc140-mt-gd.lib",
				"boost_nowide-vc140-mt-gd.lib",
				"boost_program_options-vc140-mt-gd.lib",
				"boost_python310-vc140-mt-gd.lib",
				"boost_random-vc140-mt-gd.lib",
				"boost_regex-vc140-mt-gd.lib",
				"boost_serialization-vc140-mt-gd.lib",
				"boost_stacktrace_noop-vc140-mt-gd.lib",
				"boost_stacktrace_windbg-vc140-mt-gd.lib",
				"boost_stacktrace_windbg_cached-vc140-mt-gd.lib",
				"boost_system-vc140-mt-gd.lib",
				"boost_thread-vc140-mt-gd.lib",
				"boost_timer-vc140-mt-gd.lib",
				"boost_type_erasure-vc140-mt-gd.lib",
				"boost_unit_test_framework-vc140-mt-gd.lib",
				"boost_wave-vc140-mt-gd.lib",
				"boost_wserialization-vc140-mt-gd.lib");
		}
		
        public static void AddToSolution(Solution.Configuration conf, lu.Target target)
        {
            conf.AddProject<boost_vcpkg>(target, false, "boost");
        }
    }
	
	[Sharpmake.Export]
	public class folly_vcpkg : vcpkg_workspace_project
	{
        public override void ConfigureRelease(Project.Configuration conf, Target target)
		{
			base.ConfigureRelease(conf, target);
			
			conf.LibraryFiles.Add(
				"folly.lib");
		}
	
        public override void ConfigureDebug(Project.Configuration conf, Target target)
		{
			base.ConfigureDebug(conf, target);
			
			conf.LibraryFiles.Add(
				"folly.lib");
		}
		
        public static void AddToSolution(Solution.Configuration conf, lu.Target target)
        {
            conf.AddProject<folly_vcpkg>(target, false, "folly");
        }
    }
}

