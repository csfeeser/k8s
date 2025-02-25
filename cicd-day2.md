# **Day 2 Warmup: Tag and Push an Image**  

![Funny Linux Meme](https://programmerhumor.io/wp-content/uploads/2022/11/programmerhumor-io-linux-memes-backend-memes-7cf42390548d5ac.png)

This warmup will reinforce working with container images, tagging, and pushing them to GitLab’s container registry.

## **Step 1: Create a New Project**  

Create a new project in GitLab and name it **`day-2-warmup`**.

## **Step 2: Run This Super Ugly Command**  

Copy and paste the entire command below into your terminal, then press **Enter**:

```bash
GITLAB_REGISTRY="registry.gitlab.com/alta3-instructor" IMAGE_NAME="tmnt:latest" NEW_TAG="warmup:v1" && echo "Pulling $GITLAB_REGISTRY/$IMAGE_NAME..." && docker pull "$GITLAB_REGISTRY/$IMAGE_NAME" && echo "Tagging the image as $NEW_TAG..." && docker tag "$GITLAB_REGISTRY/$IMAGE_NAME" "$NEW_TAG" && echo "Removing the original image $GITLAB_REGISTRY/$IMAGE_NAME..." && docker rmi "$GITLAB_REGISTRY/$IMAGE_NAME" && echo "Verifying the new image is present..." && docker images | grep "warmup" && echo "Done!"
```

This will:  
✅ Pull an image from **GitLab’s registry**  
✅ Tag it as **warmup:v1**  
✅ Remove the original image  
✅ Verify that **warmup:v1** exists  

## **Step 3: Tag and Push the Image to Your Project**  

Now, **tag the image** for your own repository and push it to your `day-2-warmup` project’s **container registry**. You should see your **`warmup-v1`** image listed.

## **Solution**
<details>
<summary>Click here to see the full solution!</summary>

```bash
# 1. Run the ugly command to pull and retag the image
GITLAB_REGISTRY="registry.gitlab.com/alta3-instructor" IMAGE_NAME="tmnt:latest" NEW_TAG="warmup:v1" && echo "Pulling $GITLAB_REGISTRY/$IMAGE_NAME..." && docker pull "$GITLAB_REGISTRY/$IMAGE_NAME" && echo "Tagging the image as $NEW_TAG..." && docker tag "$GITLAB_REGISTRY/$IMAGE_NAME" "$NEW_TAG" && echo "Removing the original image $GITLAB_REGISTRY/$IMAGE_NAME..." && docker rmi "$GITLAB_REGISTRY/$IMAGE_NAME" && echo "Verifying the new image is present..." && docker images | grep "warmup" && echo "Done!"

# 2. Tag the image with the user's registry (it doesn't matter what you call it)
docker tag warmup:v1 registry.gitlab.com/YOUR_USERNAME/day-2-warmup:warmup-v1

# 3. Push the image to GitLab's container registry
docker push registry.gitlab.com/YOUR_USERNAME/day-2-warmup:warmup-v1

# 4. Confirm the image exists in GitLab
# Navigate to Packages & Registries → Container Registry in the GitLab UI
```

</details>
