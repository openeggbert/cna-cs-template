using System;

namespace CNA.NET.Template;

public static class Program
{
    [STAThread]
    static void Main(string[] args)
    {
        using var game = new HelloGame();
        game.Run();
    }
}
