# Build an run a PAL docker including some of the LAAS-CNRS binaries.

## Clone the package and build the docker:

Using wstool and .rosinstall

    git clone --recursive git@github.com:Gepetto/public_pal_gepetto_dockers.git
    cd public_pal_gepetto_dockers
    make build-cache

## Run the docker:
   
In order to start a container, you can run:

    make run

In order to connect to the last conatiner ran:

    make connect


## Run Gazebo simulation with vision and plane segmentation.

Run these action sequentially in the different terminals starting with terminal
1, then 2, then 3, then 4, etc.

### Terminal 1:

    make run
    catkin config -DCMAKE_BUILD_TYPE=Debug -DINSTALL_DOCUMENTATION=OFF -DBUILD_DOCUMENTATION=OFF
    catkin build
    source install/setup.bash
    roslaunch XXX

### Terminal 2:

    make connect
    source install/setup.bash
    roslaunch XXX
