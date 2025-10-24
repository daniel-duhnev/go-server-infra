# GKE Module
Dual region architecture with 1 active and 1 passive region.

## Overview and purpose
A lean, reliable active/passive deployment pattern for two GKE clusters in different regions with a mechanism for traffic failover.

## Core ideas and design
- Use one active cluster to serve traffic normally, and one passive as standby.
- Use a Global External HTTPS Load Balancer (GCLB) with a single anycast IP as a frontend, and backends in both regions.
- LB’s health checks determine which backend serves traffic - When the active region fails health checks, the LB sends traffic to the healthy passive region automatically.

## Key components
- Frontend - single global HTTPS IP provisioned in the networking module.
- Backends - each GKE cluster exposes the application via NEGs.
- Failover - GCLB uses health checks. If active backends are unhealthy, traffic goes to passive backends.
- Changeover and tuning - control capacity per backend via backend service backend configuration - passive region is kept out of the normal traffic path until needed.

## Pre-warming and scaling passive cluster when required
- Keep small baseline in passive region - i.e. small node pool and minimal replica count, so pods start quickly on failover.
- Use Cluster Autoscaler and HPA to scale under load.

## Resources created via GKE module
- Clusters, node pools, autoscaling rules
- Ingress, NEG exports, BackendService config - backends, capacity_scaler, health checks
- Outputs - NEG names, backend group identifiers, region-specific endpoints
