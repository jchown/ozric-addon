# Ozric Addon for Home Assistant

## Overview

Ozric is a an automation engine for Home Assistant, that uses a [graph](#graph) of connected 
[nodes](#nodes) to drive the state of your lights and switches.


## <a name="graph" /> The Graph

![a picture of an Ozric graph](docs/graph.png "Ozric Graph")

The graph is the top-level entity in Ozric.

## <a name="nodes" /> Nodes

Nodes are used to represent entities in your Home Assistant installation and also to represent 
the logic driving their state. Nodes have inputs and outputs (the number varies according to the
type of node and configuration) which are connected together.   

## <a name="values" /> Values

There are four types of values that are passed between [nodes](#nodes):
* Binary - an off/on or zero/one value.
* Number - any numeric value like `42` or `3.141`.
* Color - technically both the chrominance and brightness.
* Mode - a label or name for a given state like `dark` or `evening`. 

Node inputs and outputs have a fixed value type that they can be connected to.