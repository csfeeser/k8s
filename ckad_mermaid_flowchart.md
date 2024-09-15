style='color:black;'>Taints and Tolerations</span>"]
    style AC fill:#D46A6A
    F --> AI["<span style='color:black;'>Custom Resource Definitions</span>"]
    style AI fill:#9E9E9E
    V --> W["<span style='color:black;'>Annotations</span>"]
    style W fill:#D46A6A
    V --> AB["<span style='color:black;'>Jobs and CronJobs</span>"]
    style AB fill:#D46A6A
    N --> 913349["<span style='color:black;'>Contexts</span>"]
    style 913349 fill:#FAD02E
    D --> E
    L --> H["<span style='color:black;'>ResourceQuotas</span>"]
    style H fill:#FAD02E

    subgraph Legend
        L1["<span style='color:black;'>Day One</span>"]
        L2["<span style='color:black;'>Day Two</span>"]
        L3["<span style='color:black;'>Day Three</span>"]
        L4["<span style='color:black;'>Day Four</span>"]
        L5["<span style='color:black;'>Day Five</span>"]
    end

    style L1 fill:#A1C6E7
    style L2 fill:#FAD02E
    style L3 fill:#7FB77E
    style L4 fill:#D46A6A
    style L5 fill:#9E9E9E
```
