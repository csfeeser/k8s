# CKA Task: Deployment Rollbacks and Scaling

### Objectives
In this lab, you'll be rolling back a **Deployment** to a previously stable version *AND* adjust its scale. Deployments come equipped with amazing version control features which allow for rollbacks, and tracking revision history. Knowledge of the **kubectl rollout** and **kubectl scale** command is what's being tested here. Permitted reference material you can use while taking the **CKA** exam can be found [here from kubernetes.io](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-to-a-previous-revision) -- Good luck!

### Lab Setup

1. Run the following command to setup the lab.

    `student@bchd:~$` `drill deploy-rollbacks`

### Summary

There is an existing deployment named `mufasa` in namespace `king-of-lions`. Apparently the current version is broken. Check the deployment history and rollback to a version that actually works.

> Understand Deployments and how to perform rolling rollbacks. You could be given an existing deployment that is already several revisions old. Be prepared to rollback using kubectl to a previous version.

**Weight:** 4%

### Tasks

1. Identify the Deployment and view its revision history.

0. Perform the rollback to a version which works.

0. Verify the rollback completed successfully.

0. Scale the deployment to 5 replicas.

### Hints

1. Identify the Deployment and view its revision history.
    
    <details><summary>Click</summary>
    
    You'll need to use the appropriate **kubectl rollout** command to view the revision history of the resource.
    
    </details>

0. Perform the rollback to a version which works.

    <details><summary>Click</summary>
    
    Once again, your knowledge of **kubectl rollout** is being exercised. Somehow, you'll need to rollback to a previous version, **UNDO**ing the recent update.
    
    </details>

0. Verify the rollback completed successfully.

    <details><summary>Click</summary>
    
    If the rollback is successful, the Deployment will have a status of **running**.
    
    </details>

0. Scale the deployment to 5 replicas.

    <details><summary>Click</summary>
    
    Either `kubectl scale` or `kubectl edit` can be used to do this since we don't have the manifest.
    
    </details>

### Answers

1. Identify the Deployment and view its revision history.
  
    <details><summary>Click</summary>
  
    1. Identify the Deployment we're going to be working with.
    
        `student@bchd:~$` `kubectl get deploy -n king-of-lions`
    
        ```
        NAME     READY   UP-TO-DATE   AVAILABLE   AGE
        mufasa   0/2     2            0           42m
        ```
      
        > Sure enough, we have our deployment **mufasa**, but none of the pods are working appropriately. According to the Lab Summary, there are previous revisions we may be able to rollback to. Let's check those out.
    
    0. Display the revision history of the deployment like so:

        `student@bchd:~$` `kubectl rollout history -n king-of-lions deployment mufasa`

        ```
        deployment.apps/mufasa 
        REVISION  CHANGE-CAUSE
        1         Sarabi and I didn't see you at the presentation of Simba.
        2         Before sunrise, he's your son.
        3         One day, Simba, the sun will set on my time here and will rise with you as the new king.
        4         Long Live the King -- BROKEN!
        ```

        > Luckily, the course author (you're welcome) identified that indeed the fourth revision is broken. Based on our Revision History, it would be safe to assume Revision 3 is stable, and we can attempt rolling back to revision 3 to restore the service.

    </details>

0. Perform the rollback to a version which works.
    
    <details><summary>Click</summary>

    1. You can now rollback to the previous revision with the following command:

        `student@bchd:~$` `kubectl rollout undo deployment -n king-of-lions mufasa`
    
        > This command will rollback to the previous revision, which in our case is **Revision 3**. However, if you want to be sure, you can format your command as follows to rollback to a specific revision: `kubectl rollout undo deployment manticore --to-revision=2`

    2. While you're here, let's take a look at the revision history, and how our undo changed it.

        `student@bchd:~$` `kubectl rollout history deployment -n king-of-lions mufasa`

        ```
        deployment.apps/mufasa 
        REVISION  CHANGE-CAUSE
        1         Sarabi and I didn't see you at the presentation of Simba.
        2         Before sunrise, he's your son.
        4         Long Live the King -- BROKEN!
        5         One day, Simba, the sun will set on my time here and will rise with you as the new king.
        ```
    
        > As you can see, **Revision 3** is gone completely, and we now have **Revision 5**. This happened because Revision 3 is now the active version, and since the rollback occurred after Revision 4, it now appears as Revision 5. Also note that the **CHANGE-CAUSE** annotation followed it, helping you maintain documentation through revisions. Handy that!

      </details>
      
0. Verify the rollback completed successfully.

    <details><summary>Click</summary>
    
    1. We've already double-checked the revision history, so we know the **rollback** actually occurred, but is the deployment operating correctly now? Let's see!
    
        `student@bchd:~$` `kubectl get deploy -n king-of-lions`
    
        ```
        NAME     READY   UP-TO-DATE   AVAILABLE   AGE
        mufasa   2/2     2            2           52m
        ```
    
        > Yup! It looks like we're good to go! Both Pods are available, and we're well on our way to passing this CKAD Exam.
    
    </details>

0. Scale the deployment to 5 replicas.
    <details><summary>Click</summary>
    
    1. The easiest way to do this is as follows:
    
        `student@bchd:~$` `kubectl scale deploy mufasa -n king-of-lions --replicas=5`

    0. Alternatively, you can use `kubectl edit` to open the manifest for the running deployment. Under `.spec.replicas` change the value to `5` then save and quit.
   
        `student@bchd:~$` `kubectl edit deploy mufasa -n king-of-lions`
    
    </details>
