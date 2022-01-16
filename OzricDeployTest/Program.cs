using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;

namespace OzricDeployTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            var optionsJson = File.ReadAllText("/data/options.json");
            var options = JsonSerializer.Deserialize(optionsJson, typeof(Dictionary<string, object>));
            
            Console.WriteLine("Options: " + JsonSerializer.Serialize(options));
        }
    }
}