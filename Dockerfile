FROM registry.gitlab.com/pal-robotics-public/talos-simulation:devel

SHELL ["/bin/bash", "-c"]

RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Add robotpkg package inside the docker.
ADD http://robotpkg.openrobots.org/packages/debian/robotpkg.key /
RUN --mount=type=cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,sharing=locked,target=/var/lib/apt \
    --mount=type=cache,sharing=locked,target=/root/.cache \
    apt-key add /robotpkg.key
RUN echo "deb [arch=amd64] http://robotpkg.openrobots.org/wip/packages/debian/pub ferrum robotpkg" > /etc/apt/sources.list.d/robotpkg.list
RUN echo "deb [arch=amd64] http://robotpkg.openrobots.org/packages/debian/pub ferrum robotpkg" >> /etc/apt/sources.list.d/robotpkg.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    robotpkg-cppadcodegen \
    robotpkg-py27-crocoddyl robotpkg-py27-pinocchio=2.6.17 robotpkg-py27-example-robot-data=4.0.7 robotpkg-py27-eigenpy=2.9.2 robotpkg-pinocchio=2.6.17  robotpkg-py27-hpp-fcl=2.2.0 robotpkg-hpp-fcl=2.2.0 robotpkg-example-robot-data=4.0.7 robotpkg-cppadcodegen
# robotpkg-py27-crocoddyl

ENV PAL_DISTRO=ferrum
ENV PAL_PREFIX=/opt/pal/${PAL_DISTRO}

ENV CMAKE_PREFIX_PATH=$PAL_PREFIX:$CMAKE_PREFIX_PATH \
      LD_LIBRARY_PATH=$PAL_PREFIX/lib:$LD_LIBRARY_PATH \
                 PATH=$PAL_PREFIX/bin:$PATH \
      PKG_CONFIG_PATH=$PAL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH \
     ROS_PACKAGE_PATH=$PAL_PREFIX/share:$ROS_PACKAGE_PATH

RUN find $PAL_PREFIX -name dist-packages > /usr/lib/python2.7/dist-packages/pal.pth

ENV ROBOTPKG_BASE=/opt/openrobots

ENV CMAKE_PREFIX_PATH=$ROBOTPKG_BASE:$CMAKE_PREFIX_PATH \
      LD_LIBRARY_PATH=$ROBOTPKG_BASE/lib:$LD_LIBRARY_PATH \
                 PATH=$ROBOTPKG_BASE/bin:$ROBOTPKG_BASE/sbin:$PATH \
      PKG_CONFIG_PATH=$ROBOTPKG_BASE/lib/pkgconfig:$PKG_CONFIG_PATH \
     ROS_PACKAGE_PATH=$ROBOTPKG_BASE/share:$ROS_PACKAGE_PATH

RUN find $ROBOTPKG_BASE -name site-packages > /usr/lib/python2.7/dist-packages/robotpkg.pth

