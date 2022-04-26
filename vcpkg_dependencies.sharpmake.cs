using Sharpmake;
using System;

[module: Sharpmake.Include("common.sharpmake.cs")]

// Generated
namespace lu
{
	public class export_project : Project
	{
		// Paths have to be constructed relative to the sharpmake exe, which we will assume is installed in the workspace root in bin/Sharpmake
		public string ExecutablePath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
		public string WorkspaceBinRoot = "[project.ExecutablePath]/";
		public string WorkspaceRoot = "[project.ExecutablePath]/../";
		public string GeneratedRoot = "[project.WorkspaceRoot]/out/sharpmake.generated";
		public string BuildRoot = "[project.GeneratedRoot]";

		public export_project() : base(typeof(Target))
		{
			AddTargets(new lu.Target(
				Platform.win64,
				DevEnv.vs2022,
				Optimization.Debug | Optimization.Release /*| Optimization.Retail*/)); // TODO: get targets from the user side
		}

		[Configure(), ConfigurePriority(1)]
		public virtual void ConfigureAll(Configuration conf, Target target)
		{
		}

		[Configure(Optimization.Debug), ConfigurePriority(2)]
		public virtual void ConfigureDebug(Configuration conf, Target target)
		{
		}

		[Configure(Optimization.Release), ConfigurePriority(3)]
		public virtual void ConfigureRelease(Configuration conf, Target target)
		{
		}
	}

	[Sharpmake.Export]
	public class vcpkg_project : export_project
	{
		public override void ConfigureRelease(Project.Configuration conf, Target target)
		{
			base.ConfigureRelease(conf, target);

			// Add root include path for vcpkg packages.
			conf.IncludePaths.Add(@"[project.WorkspaceRoot]\out\exported\installed\x64-windows-static\include");

			// Add root lib path for vcpkg packages.
			conf.LibraryPaths.Add(@"[project.WorkspaceRoot]\out\exported\installed\x64-windows-static\lib");
		}

		public override void ConfigureDebug(Project.Configuration conf, Target target)
		{
			base.ConfigureDebug(conf, target);

			// Add root include path for vcpkg packages.
			conf.IncludePaths.Add(@"[project.WorkspaceRoot]\out\exported\installed\x64-windows-static\include");

			// Add root lib path for vcpkg packages.
			conf.LibraryPaths.Add(@"[project.WorkspaceRoot]\out\exported\installed\x64-windows-static\debug\lib");
		}
	}

	[Sharpmake.Export]
	public class boost_vcpkg : vcpkg_project
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
            conf.AddProject<boost_vcpkg>(target, false, "boostorg");
        }
    }
}

