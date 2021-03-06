# Generating Graph Files

What are the dependencies in this build? What commits are included and what how far are they from 
those in HEAD? These were some of the common questions asked during meetings. In order to answer them
we had to go check different files and child repos and make sure we had the right idea.

Today, with the help of `darc` and the data stored in the Build Asset Registry we can generate different
kind of graph files which contain the data needed to take the right decisions and answer the questions
mentioned above. 

## The command

Under the scenes the thing generating the graph files is `darc` by running the `get-dependency-graph` command.

## Shiproom data

### Enabling graph generation

Graph generation is off by default so you'd need to enable it in your official builds. As well, you'd need to define
whether you want toolset dependencies included in your graph. This is also off by default.

If your build definition relies on `/eng/common/templates/jobs/jobs.yml` to execute the jobs you just need to
define the following under template parameters:

```yaml
- template: /eng/common/templates/jobs/jobs.yml
  parameters:
    graphFileGeneration:
      enabled: true
      includeToolset: true
```

The above enables graph generation where the graphs will include toolset dependencies. If toolset dependencies are not needed
just remove `includeToolset: true`

### Generated Files

* graph-flat.txt: includes the contents of a dependency graph with unique sets of repository+branch
* graph-full.txt: includes the contents of a complete dependency graph
* graphviz.txt: includes the contents of a graph that can be then pasted in http://www.webgraphviz.com
* graph.png: the same image that would be generated by graphviz.txt in http://www.webgraphviz.com

## Generating the graph locally

As mentioned above, we use darc to generate the different graphs. The base command is the same and we just need to pass a different
set of options. 

* To generate a full graph: `darc get-dependency-graph --output-file <full-graph-file-path>`
* To generate a flat graph: `darc get-dependency-graph --flat --output-file <flat-graph-file-path>`
* To generate a graphviz graph: `darc get-dependency-graph --graphviz <graphviz-graph-file-path>`

There are more options for this command for you to include toolset dependencies, coherency information, etc. For a list of all the
options execute `darc get-dependency-graph -h`.

## Samples

* [Arcade](https://github.com/dotnet/arcade/blob/master/azure-pipelines.yml#L39) - Graph generation is deferred to 
`/eng/common/templates/jobs/jobs.yml`
* [Core-SDK](https://github.com/dotnet/core-sdk/blob/master/.vsts-ci.yml#L280) - Graph generation is defined in the main
build definition