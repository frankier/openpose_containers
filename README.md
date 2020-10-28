This repository first builds a Docker base, upon which a Singularity container
which can use different versions of OpenPose is based.

To rebuild Singularity files
1. Directly make your changes to `singularity_template`.
2. Run `make`.
3. Add and push both `singularity_template` and the generated files so they can
   be build on Singularity Hub
