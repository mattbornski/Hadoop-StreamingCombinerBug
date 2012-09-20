Many of my jobs rely on the comparator sort to make sure that the reducer processes receive the map outputs in the correct order.  This is critical so that the reducer does not have to maintain excessive state.  In the interests of efficiency, I'd also like to use a combiner.  However, in debugging my jobs, I've noticed the following behavior:

1. Run job with mapper, combiner, and reducer.  Job output contains duplicates or (if using thresholding in the reducer) contains fewer than expected outputs.
2. Start debugging and manually trying out steps one by one.
3. Begin scratching head, as everything looks good.
4. Give up on reason and start removing things until stuff breaks in a different way.

After a few minutes of (4) I noticed that the existence of the combiner, regardless of the actual function of the combiner, seemed to be related to the unexpected results of the jobs.  It appears that when a combiner is configured, some or all of the records given to the combiner are not ordered by the comparator.

I can reproduce this behavior but have not yet found a cause in the Hadoop or Hadoop Streaming code, nor received any outside opinions confirming or disputing my interpretation.