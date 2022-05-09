using Sharpmake;
using System;

[module: Sharpmake.Include("base.sharpmake.cs")]

namespace lu
{
	public class vcpkg_project : Project
	{
		// Paths have to be constructed relative to the sharpmake exe, which we will assume is installed in the workspace root in bin/Sharpmake
		public string ExecutablePath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
		public string WorkspaceBinRoot = "[project.ExecutablePath]/";
		public string WorkspaceRoot = "[project.ExecutablePath]/../";
		public string GeneratedRoot = "[project.WorkspaceRoot]/pkg/sharpmake.generated";
		public string BuildRoot = "[project.WorkspaceRoot]/out";

		public vcpkg_project() : base(typeof(Target))
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

		[Configure(Optimization.Release), ConfigurePriority(3)]
		public virtual void ConfigureRelease(Project.Configuration conf, Target target)
		{
			// Add root include path for vcpkg packages.
			conf.IncludePaths.Add(@"[project.WorkspaceRoot]\pkg\install_root\x64-windows-static\include");

			// Add root lib path for vcpkg packages.
			conf.LibraryPaths.Add(@"[project.WorkspaceRoot]\pkg\install_root\x64-windows-static\lib");
		}

		[Configure(Optimization.Debug), ConfigurePriority(2)]
		public virtual void ConfigureDebug(Project.Configuration conf, Target target)
		{
			// Add root include path for vcpkg packages.
			conf.IncludePaths.Add(@"[project.WorkspaceRoot]\pkg\install_root\x64-windows-static\include");

			// Add root lib path for vcpkg packages.
			conf.LibraryPaths.Add(@"[project.WorkspaceRoot]\pkg\install_root\x64-windows-static\debug\lib");
		}
	}
}

