# coretrace-testkit
It’s a small Python testing framework to run a tool (compiler/analyzer) and validate its output. Each test defines input sources and options, then checks the exit code, the presence of the produced binary and its format (ELF/Mach-O), and/or specific content in stdout/stderr. Tests run in a temporary workspace and use a simple reporter.
