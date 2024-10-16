#!/bin/bash

# Create the namespace 'critters'
kubectl create namespace critters

# Array of 20 animals for pod names, starting with different letters
animals=(aardvark bear cat dog elephant fox giraffe hippo iguana jaguar koala lion monkey newt owl panda quail rabbit snake tiger)

# Loop to create 20 pods with a small container (busybox) and different labels
for i in {0..19}
do
  animal=${animals[$i]}

  # Generate animal-related labels based on the index for a mix of labels
  if [ $((i % 2)) -eq 0 ]; then
    labels="species=mammal"
  else
    labels="species=non-mammal"
  fi
  
  if [ $((i % 3)) -eq 0 ]; then
    labels="$labels,habitat=land"
  else
    labels="$labels,habitat=water"
  fi

  if [ $((i % 4)) -eq 0 ]; then
    labels="$labels,diet=herbivore"
  else
    labels="$labels,diet=carnivore"
  fi

  # Create each pod with a small busybox container and the generated labels
  kubectl run $animal --image=busybox --namespace=critters --restart=Never --labels="$labels" --command -- sleep 3600
done

echo "20 pods created with varying labels!"
