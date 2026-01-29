# coretrace-tester-framework

Minimal Python test framework used across CoreTrace repos.

## Install (editable)
```bash
python3 -m pip install -e .
```

## Install (from git)
```bash
python3 -m pip install "git+https://github.com/CoreTrace/coretrace-testkit.git"
# or using SSH
python3 -m pip install "git+ssh://git@github.com/CoreTrace/coretrace-testkit.git"
```

## Import
```python
from ctestfw.runner import CompilerRunner, RunnerConfig
```

## Example (minimal)
```python
from pathlib import Path

from ctestfw.runner import CompilerRunner, RunnerConfig
from ctestfw.plan import CompilePlan
from ctestfw.framework.testcase import TestCase
from ctestfw.framework.suite import TestSuite
from ctestfw.assertions.compiler import (
    assert_exit_code,
    assert_output_exists,
    assert_native_binary_kind,
)

# Runner (your compiler/driver)
runner = CompilerRunner(
    RunnerConfig(
        executable=Path("/usr/bin/clang"),  # adjust to your tool
        default_timeout_s=20.0,
        default_env=None,
    )
)

# Compile plan
plan = CompilePlan(
    name="hello",
    sources=[Path("/absolute/path/to/hello.c")],
    out=Path("hello"),
    extra_args=["-O2"],
)

# Test case + assertions
case = TestCase(
    name="hello_builds",
    plan=plan,
    assertions=[
        assert_exit_code(0),
        assert_output_exists(),
        assert_native_binary_kind(),
    ],
)

# Suite + run
suite = TestSuite(name="smoke", cases=[case])
report = suite.run(runner, root_workspace=Path("tmp/ctestfw"))

print(report.ok())
for r in report.reports:
    print(r.name, r.ok, r.errors)
```
