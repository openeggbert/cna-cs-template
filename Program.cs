using System;
using System.Linq;

namespace CnaCsTemplate;

public static class Program
{
    [STAThread]
    static void Main(string[] args)
    {
        bool smokeTest = args.Contains("--smoke-test");
        using var game = new HelloGame(smokeTest);
        game.Run();
    }
}
