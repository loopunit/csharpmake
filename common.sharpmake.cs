using Sharpmake;
using System;

[module: Sharpmake.Include("base.sharpmake.cs")]

// User-overrideable
namespace lu
{
    [Sharpmake.Generate]
    public class common_project : base_project
    {
    }

    [Sharpmake.Generate]
    public class common_solution : base_solution
    {
    }
}

