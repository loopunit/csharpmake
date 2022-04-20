using Sharpmake;
using System;

namespace lu
{
    public class Target : ITarget
    {
        public Optimization Optimization;

        public Platform Platform;

        public BuildSystem BuildSystem;

        public DevEnv DevEnv;

        public OutputType OutputType;

        public DotNetFramework Framework;

        public Blob Blob;

        public string FrameworkFolder => Framework.ToFolderName();

        public override string Name => Optimization.ToString();

        public Target()
        {
        }

        public Target(Platform platform, DevEnv devEnv, Optimization optimization, OutputType outputType = OutputType.Lib, Blob blob = Blob.NoBlob, BuildSystem buildSystem = BuildSystem.MSBuild, DotNetFramework framework = DotNetFramework.v3_5)
        {
            Platform = platform;
            DevEnv = devEnv;
            Optimization = optimization;
            OutputType = outputType;
            Framework = framework;
            BuildSystem = buildSystem;
            Blob = blob;
        }
    }

    [Sharpmake.Generate]
    public class base_project : Project
    {
		// Paths have to be constructed relative to the sharpmake exe, which we will assume is installed in the workspace root in bin/Sharpmake
        public string ExecutablePath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
        public string WorkspaceBinRoot = "[project.ExecutablePath]/";
        public string WorkspaceRoot = "[project.ExecutablePath]/../";
        public string GeneratedRoot = "[project.WorkspaceRoot]/out/sharpmake.generated";
        public string BuildRoot = "[project.GeneratedRoot]";

        public base_project() : base(typeof(Target))
        {
            SourceRootPath = "[project.SharpmakeCsPath]";
            IsFileNameToLower = false;
        }

        public virtual void AddDefaultTargets()
        {
            AddTargets(new lu.Target(
                Platform.win64,
                DevEnv.vs2022,
                Optimization.Debug | Optimization.Release /*| Optimization.Retail*/)); // TODO: get targets from the user side
        }

        [Configure()]
        public virtual void ConfigureAll(Configuration conf, Target target)
        {
            conf.Name = "[target.Optimization]_[target.Platform]";
            conf.ProjectFileName = "[project.Name]_[target.DevEnv]_[target.Platform]";
            conf.ProjectPath = "[project.GeneratedRoot]/[project.Name]";
            conf.IntermediatePath = "[project.BuildRoot]/[target.Platform]/[target.Optimization]/obj/[project.Name]";
            conf.TargetLibraryPath = "[project.BuildRoot]/[target.Platform]/[target.Optimization]/lib/[project.Name]";
            conf.TargetPath = "[project.BuildRoot]/[target.Platform]/[target.Optimization]/bin/[project.Name]";
            conf.Options.Add(Options.Vc.Linker.TreatLinkerWarningAsErrors.Enable);
        }
    }

    [Sharpmake.Generate]
    public class base_solution : Solution
    {
		// Paths have to be constructed relative to the sharpmake exe, which we will assume is installed in the workspace root in bin/Sharpmake
        public string ExecutablePath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
        public string WorkspaceBinRoot = "[solution.ExecutablePath]/";
        public string WorkspaceRoot = "[solution.ExecutablePath]/../";
        public string GeneratedRoot = "[solution.WorkspaceRoot]";

        public base_solution() : base(typeof(Target))
        {
            IsFileNameToLower = false;
        }

        public virtual void AddDefaultTargets()
        {
            AddTargets(new lu.Target(
                Platform.win64,
                DevEnv.vs2022,
                Optimization.Debug | Optimization.Release /*| Optimization.Retail*/)); // TODO: get targets from the user side
        }

        [Configure]
        public virtual void ConfigureAll(Solution.Configuration conf, Target target)
        {
            conf.SolutionPath = "[solution.GeneratedRoot]";
        }
    }
}

