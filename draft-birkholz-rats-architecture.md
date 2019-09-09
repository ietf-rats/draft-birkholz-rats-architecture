---
title: Remote Attestation Procedures Architecture
abbrev: RATS Arch & Terms
docname: draft-birkholz-rats-architecture-latest
wg:
stand_alone: true
ipr: trust200902
area: Security
kw: Internet-Draft
cat: std
pi:
  toc: yes
  sortrefs: yes
  symrefs: yes

author:
- ins: H. Birkholz
  name: Henk Birkholz
  org: Fraunhofer SIT
  abbrev: Fraunhofer SIT
  email: henk.birkholz@sit.fraunhofer.de
  street: Rheinstrasse 75
  code: '64295'
  city: Darmstadt
  country: Germany
- ins: M. Wiseman
  name: Monty Wiseman
  org: GE Global Research
  abbrev: GE Global Research
  email: monty.wiseman@ge.com
  street: ""
  code: ""
  city: ""
  region: ""
  country: USA
- ins: H. Tschofenig
  name: Hannes Tschofenig
  org: ARM Ltd.
  abbrev: ARM Ltd.
  email: hannes.tschofenig@gmx.net
  street: 110 Fulbourn Rd
  code: "CB1 9NJ"
  city: Cambridge
  country: UK
- ins: N. Smith
  name: Ned Smith
  org: Intel Corporation
  abbrev: Intel
  email: ned.smith@intel.com
  street: ""
  code: ""
  city: ""
  country: USA

normative:
  RFC2119:
  I-D.richardson-rats-usecases: rats-usecases

informative:
  DOLEV-YAO: DOI.10.1109_tit.1983.1056650
  RFC5209:
  RFC3552:
  RFC4949:

--- abstract

The Remote ATtestation procedureS (RATS) architecture facilitates interoperability of attestation mechanisms by defining a set of participant roles and interactions that reveal information about the trustworthiness attributes of an attester's computing environment.
By making trustworthiness attributes explicit, they can be evaluated dynamically and within an operational context where risk mitigation depends on having a more complete understanding of the possible vulnerabilities germane to the attester's environment.

--- middle

# Introduction

The long-standing Internet Threat Model {{RFC3552}} focuses on threats to the communication channel, as pioneered by Dolev and Yao {{DOLEV-YAO}} in 1983.
However, threats to the endpoint {{RFC5209}} and system components {{RFC4949}} of transited communication gear (i.e. hosts) are increasingly relevant for assessing the trustworthiness properties of a communication channel.
Beyond the collection and conveyance of security posture {{RFC5209}} about an endpoint (host), remote attestation provides believable trustworthiness claims ("Evidence") about an endpoint (host).

## RATS in a nutshell

RATS architecture provides a basis to assess the trustworthiness of endpoints by other parties:

* In remote attestation workflow, trustworthiness Claims are accompanied by a proof of veracity. Typically, this proof is a cryptographic expression such as a digital signature or message digest. Trustworthiness Claims with proof is what makes attestation Evidence believable.
* A corresponding attestation provisioning workflow uses trustworthiness Claims to convey believable Endorsements and Known-Good-Values used by a Verifier to assess Evidence.

In RATS architecture specific content items are identified (and described in more detail below):

* Evidence is provable Claims about a specific computing environment made by an Attester.
* Known-Good-Values are reference Claims used to assess Evidence.
* Endorsements are reference Claims about the environment protecting the Attestation key. It answers the question "why Evidence is believable"
* Attestation Results are the output from the assessment of Evidence, Known-Good-Values and Endorsements.

Attestation Results are the output of RATS attestation. Appraisal of attestation Results can be multi-faceted, but is out of scope for RATS architecture.
If appropriate Endorsements about the Attester are available, Known-Good-Values about the Attester are available, and if the Attester is capable of creating believable Evidence -- then the Verifier is able to create Attestation Results that enable Relying Parties to establish a level of confidence in the trustworthiness of the Attester.

# Terminology

Conveyance:

: a mechanism for transferring RATS Evidence, Endorsements, Known-Good-Values or Attestation Results.

Entity:

: a user, organization, device or computing environment.

Principal:

: an Entity that implements RATS roles and creates provable Claims or Results.

Trustworthiness:

: an expectation about a computing environment that it will behave in a way that is expected and nothing more.

Computing Environment:

: a computing context consisting of system components.

Attesting Computing Environment:

: a computing environment capabile of monitoring and attesting a target Computing Environment.

Attested Computing Environment:

: a target computing environment that is monitored and attested by an Attesting Computing Environment.

## Requirements Notation

{::boilerplate bcp14}

# Conceptual Overview

In network protocol exchanges, it is often the case that one entity (a Relying Party) requires an assessment of the trustworthiness of a remote entity (an Attester or specifc system components {{RFC4949}} thereof).
Remote ATtestation procedureS (RATS) enable Relying Parties to establish a level of confidence in the trustworthiness of remote system components through the creation of attestation evidence by remote system components and a processing chain of architectural constituents towards the relying party.

The corresponding trustworthiness attributes processed may not be just a finite set of values. Additionally, the system characteristics of remote components themselves have an impact on the veracity of trustworthiness attributes included in Evidence.
Attester environments can vary widely ranging from those highly resistant to attacks to those having little or no resistance to attacks.
Configuration options, if set poorly, can result in a highly resistant environment being operationally less resistant.
Computing Environments are often malleable being constructed from re-programmable hardware, firmware, software and updatable memory.
When a trustworthy environment changes, the question has to be asked whether the change transitioned the environment from a trustworthy state to an untrustworthy state.
The RATS architecture provides a framework for anticipating when a relevant change with respect to a trustworthiness attribute occurs, what changed and how relevant it is.
A remote attestation framework also creates a context for enabling an appropriate response by applications, system software and protocol endpoints when changes to trustworthiness attributes do occur.

## Computing Environments

In the RATS context, a Claim is a specific trustworthiness attribute that pertains to a particular Computing Environment of an Attester.
The set of possible Claims is expected to follow the possible computing environments that support attestation.
In other words, identical (i.e. same type, model, versions, components and composition) Attesting Computing Environments can create different Claim values that still compose valid Evidence due to different computing contexts. Exemplary Claims include flight vectors or learned configuration.

Likely, there are a set of Claims that is widely applicable across most, if not all environments.
Conversely, there are Claims that are unique to specific environments.
Consequently, the RATS architecture incorporates extensible mechanisms for representing Claims.

Computing Environments can be complex structurally. In general, every Attester consists of multiple components (e.g. memory, CPU, storage, networking, firmware, software).
Components are computational elements that can be linked and composed to form computational pipelines, arrays and networks (e.g. a BIOS, a bootloader, or a trusted execution environment).

An Attester includes at least one Computing Environment that is able to create attestation Evidence (the Attesting Computing Environment) about other Computing Environments (the Attested Computing Environments).
Not every computational element of an Attester is expected to be a Computing Environment capable of remote attestation.
Analogously, remote attestation capable Computing Environments may not be capable of attesting to (creating evidence about) every computational element that interacts with the Computing Environment.
A Computing Environment with an attestation capability can only be endorsed by an external entity and cannot create believable evidence about itself by its own.

A Computing Environment with the capability of remote attestation:

* is separate from other Attested Computing Environments (about which attestation evidence is created), and
* is enabling the role of an Attester in the RATS architecture.

A Computing Environment with the capability of remote attestation and taking on the role of an Attester has the following duties in order to create Evidence:

* monitoring trustworthiness attributes of other Computing Environments,
* collecting trustworthiness attributes and create Claims about them,
* serialize Claims using interoperable representations,
* provide integrity protection for the sets of Claims, and
* add appropriate attestation provenance attributes about the sets of Claims.

## Trustworthiness

The trustworthiness of remote attestation capabilities is also a consideration for the RATS architecture.
It should be possible to understand the trustworthiness properties of the remote attestation capability for any set of claims of a remote attestation flow via verification operations.
The RATS architecture anticipates recursive trustworthiness properties and the need for termination.
Ultimately, a portion of a computing environment's trustworthiness is established via non-automated means.
For example, design reviews, manufacturing process audits and physical security.
For this reason, trustworthy RATS depend on trustworthy manufacturing and supply chain practices.

## RATS Workflow

The basic function of RATS is creation, conveyance and appraisal of attestation evidence.
An Attester creates attestation Evidence (signed claims) that are conveyed to a Verifier for appraisal.
The appraisals compare Evidence with expected known good values called Assertions obtained from supply entities called Asserters.
There can be multiple forms of appraisal (e.g., software integrity verification, device composition and configuration verification, device identity and provenance verification).
Attestation Results are the output of appraisals that are signed and conveyed to Relying Parties. Attestation Results provide the basis by which the Relying Party may determine a level of confidence to place in the application data or operations that follow.

RATS architecture defines attestation Roles (i.e., Attester, Verifier, Asserter and Relying Party), the messages they exchange, their structure and the various legal ways in which roles may be hosted, combined and divided. RATS messages are defined by an information model that defines claims, environment and protocol semantics. Information model representations are realized as data structure and conveyance protocol binding specifications.

## Interoperability between RATS

The RATS architecture anticipates use of information modeling techniques that describe computing environment structures -- their components/computational elements and corresponding capabilities -- so that verification operations may rely on the information model as an interoperable way to navigate the structural complexity.

# RATS Architecture

## Goals

RATS architecture has the following goals:

* Enable semantic interoperability of attestation semantics through information models about computing environments and trustworthiness.
* Enable data structure interoperability related to claims, endpoint composition / structure, and end-to-end integrity and confidentiality protection mechanisms.
* enable programmatic assessment of trustworthiness. (Note: Mechanisms that manage risk, justify a level of confidence, or determine a consequence of an attestation result are out of scope).
* Use-case driven architecture and design (RATS use cases are summarized in {{-rats-usecases}}).
* Terminology conventions that are consistently applied across RATS specifications.
* Reinforce trusted computing principles that include attestation.

## Attestation Principles

Specifications developed by the RATS working group apply the following principles:

* Freshness - replay of previously asserted Claims about an Attested Computing Environment can be detected.
* Identity - the Attesting Computing Environment is identifiable (non-anonymous).
* Context - the Attested Computing Environment is well-defined (unambiguous).
* Provenance - the origin of Claims with respect to the Attested and Attesting Computing Environments are known.
* Validity - the expected lifetime of Claims about an Attested Computing Environment is known.
* Relevance - the Claims associated with the Attested Computing Environment pertain to trustworthiness metrics.
* Veracity - the believability (level of confidence) of Claims is based on verifiable proofs.

## RATS Roles and Messages

The RATS Roles (roles) are performed by RATS Principals.

The RATS Architecture provides the building blocks to compose various RATS roles by leveraging existing and new protocols. It defines architecture for composing RATS roles with principals and models their interactions.

Figure {{figalllevels}} provides an overview of the relationships between RATS Roles and the messages they exchange.

{:rats: artwork-align="center"}

~~~~ RATS
+----------------+                     +-----------------+
|                |  Known-Good-Values  |                 |
|   Asserter(s)  |-------------------->|    Verifier     |
|                |  Endorsements   /-->|                 |
+----------------+                 |   +-----------------+
                                   |            |
                                   |            |
                                   |            |
                                   |            |Attestation
                                   |            |Results
                                   |            |
                                   |            |
                                   |            v
+----------------+                 |   +-----------------+
|                |    Evidence     |   |                 |
|    Attester    |-----------------/   |  Relying Party  |
|                |                     |                 |
+----------------+                     +-----------------+

~~~~
{:rats #figalllevels title="RATS Roles"}

### Roles

RATS roles are implemented by principals that possess cryptographic keys used to protect and authenticate Claims or Results.

Attester:

: An Attestation Function that creates Evidence by collecting, formatting and protecting (e.g., signing) Claims.
It presents Evidence to a Verifier using a conveyance mechanism or protocol.

Verifier:

: An Attestation Function that accepts Evidence from an Attester using a conveyance mechanism or protocol.
It also accepts Provable Assertions from an Asserter using a conveyance mechanism or protocol.
It verifies the protection mechanisms, parses and evaluates Evidence according to good known-valid (or known-invalid) Claims.
It produces Attestation Results that are formatted and protected (e.g., signed).
It presents Attestation Results to a Relying Party using a conveyance mechanism or protocol.

Asserter:

: An Attestation Function that generates reference Claims about both the Attesting Computing Environment and the Attested Computing Environment.
The manufacturing and development processes are presumed to be trustworthy processes.
In other words the Asserter is presumed, by a Verifier, to produce valid Claims.
The function collects, formats and protects (e.g. signs) valid Claims known as Endorsements and Known-Good-Values.
It presents provable Claims to a Verifier using a conveyance mechanism or protocol.

Relying Party:

: An Attestation Function that accepts Attestation Results from a Verifier using a conveyance mechanism or protocol.
It assesses Attestation Results protections, parses and appraises attestation results according to an appraisal context (Note: definition of the appraisal context is out-of-scope).

### Role Messages

Claims:

: Statements about trustworthiness characteristics of an Attested Computing Environment.

: The veracity of a Claim is determined by the reputation of the entity making the Claim. (Note: Reputation may involve identifying, authenticating and tracking transactions associated with an entity. Remote Attestation may be used to establish entity reputation, but not exclusively. Other reputation mechanisms are out-of-scope).

Evidence:

: Claims that are formatted and protected by an Attester.

: Evidence SHOULD satisfy Verifier expectations for freshness, identity, context, provenance, validity, relevance and veracity.

Known-Good-Values:

: Claims about the Attested Computing Environment. Typically, KGV Claims are message digests of firmware, software or configuration data supplied by various vendors.
If an Attesting Computing Environment implements cryptography, they include Claims about key material.

: Like Claims, Known-Good-Values SHOULD satisfy a Verifier's expectations for freshness, identity, context, provenance, validity, relevance and veracity.
Known-Good-Values are reference Claims that are - like Evidence - well formatted and protected (e.g. signed).

Endorsements:

: Claims about immutable and implicit characteristics of the Attesting Computing Environment. Typically, endorsement Claims are created by manufacturing or supply chain entities.

: Endorsements are intended to increase the level of confidence with respect to Evidence created by an Attester.

Attestation Results:

: Statements about the output of an appraisal of Evidence that are created, formatted and protected by a Verifier.

: Attestation Results provide the basis for a Relying Party to establsh a level of confidence in the trustworthiness of an Attester.
Attestation Results SHOULD satisfy Relying Party expectations for freshness, identity, context, provenance, validity, relevance and veracity.

## RATS Principals

RATS Principals are entities, users, organizations, devices and computing environments (e.g., devices, platforms, services, peripherals).
 can take on one or more RATS Roles.

RATS Principals may implement one or more RATS Roles. Role interactions occurring within the same RATS Principal are out-of-scope.

The methods whereby RATS Principals may be identified, discovered, authenticated, connected and trusted, though important, are out-of-scope.

Principal operations that apply resiliency, scaling, load balancing or replication are generally believed to be out-of-scope.

{:rats: artwork-align="center"}

~~~~ RATS
+------------------+   +------------------+
|  Principal 1     |   |  Principal 2     |
|  +------------+  |   |  +------------+  |
|  |            |  |   |  |            |  |
|  |    Role 1  |<-|---|->|    Role 2  |  |
|  |            |  |   |  |            |  |
|  +------------+  |   |  +------------+  |
|                  |   |                  |
|  +-----+------+  |   |  +-----+------+  |
|  |            |  |   |  |            |  |
|  |    Role 2  |<-|---|->|    Role 3  |  |
|  |            |  |   |  |            |  |
|  +------------+  |   |  +------------+  |
|                  |   |                  |
+------------------+   +------------------+
~~~~
{:rats #Principals title="RATS Principals-Role Composition"}

RATS Principals have the following properties:
* Multiplicity - Multiple instances of RATS Principals that possess the same RATS Roles can exist.
* Composition - RATS Principals possessing different RATS Roles can be combined into a singleton RATS Principal possessing the union of RATS Roles. RATS Interactions between combined RATS Principals is uninteresting.
* Decomposition -  A singleton RATS Principal possessing multiple RATS Roles can be divided into multiple RATS Principals.
RATS Interactions may occur between them.

# Security Considerations
RATS Evidence, Verifiable Assertions and Results SHOULD use formats that support end-to-end integrity protection and MAY support end-to-end confidentiality protection. Replay attack prevention MAY be supported if a Nonce Claim is included. Nonce Claims often piggy-back other information and can convey attestation semantics that are of essence to RATS, e.g. the last four bytes of a challenge nonce could be replaced by the IPv4 address-value of the Attester in its response.

All other attacks involving RATS structures are not explicitly addressed by RATS architecture. Additional security protections MAY be required of conveyance mechanisms. For example, additional means of authentication, confidentiality, integrity, replay, denial of service and privacy protection of RATS payloads and Principals may be needed.
