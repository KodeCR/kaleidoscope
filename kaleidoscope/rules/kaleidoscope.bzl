# load(":monocle.bzl", "ImageInfo", "ContainerInfo")

# def _kaleidoscope_compiler_impl(ctx):
#     print("Kaleidoscope start")
#     executable = ctx.actions.declare_file("kaleidoscope_compiler")
#     print(ctx.attr.container[ContainerInfo].id)
#     print(ctx.attr.image[ImageInfo].id)
#      # args = ctx.attr.args
#      # cmd = ["docker", "run", "--rm", "monocle"] + args
#      # result = ctx.execute(cmd)
#      # if result.return_code != 0:
#      #     fail("Monocle run failed: " + result.stderr)
#      # print(result.stdout)
#      # fail("Monocle start invoked")
#     ctx.actions.write(
#         output = executable,
#         # content = "#!/bin/bash\nOUT=${@: -1}\necho \"$0: sample output\" > ${OUT%?}d", #\necho \"$0: sample output\" > ${OUT}%?}o",
#         content = '''#!/bin/bash
# echo "$0: running sample cc_library compiler (produces .o output)."
# DOTD_FILE=${@: -1}
# OBJECT_FILE=${DOTD_FILE%?}o
# echo "$0: sample .o output" > $OBJECT_FILE
# echo "sample .d output ($0)" > $DOTD_FILE''',
#         is_executable = True,
#     )
#     return [DefaultInfo(files = depset([executable]))]

# kaleidoscope_compiler = rule(
#     implementation = _kaleidoscope_compiler_impl,
#     attrs = {
#         "image": attr.label(providers = [ImageInfo], default = "//containers/monocle:monocle_image"),
#         "container": attr.label(providers = [ContainerInfo], default = "//containers/monocle:monocle_container"),
#     },
# )
