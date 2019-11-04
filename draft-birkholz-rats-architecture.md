---
title: Remote Attestation Procedures Architecture
abbrev: RATS Arch & Terms
docname: draft-birkholz-rats-architecture-latest
wg: RATS Working Group
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
- ins: M. Richardson
  name: Michael Richardson
  org: Sandelman Software Works
  email: mcr+ietf@sandelman.ca
  street: ""
  code: ""
  city: ""
  region: ""
  country: Canada

normative:
  RFC2119:
  RFC8174:

informative:
  I-D.ietf-teep-architecture: TEEP
  DOLEV-YAO: DOI.10.1109_tit.1983.1056650
  ABLP:
    title: A Calculus for Access Control in Distributed Systems
    author:
    - ins: M. Abadi
      name: Martin Abadi
    - ins: M. Burrows
      name: Michael Burrows
    - ins: B. Lampson
      name: Butler Lampson
    - ins: G. Plotkin
      name: Gordon Plotkin
    seriesinfo:
      Springer: Annual International Cryptology Conference
      page: 1-23
      DOI: 10.1.1.36.691
    date: 1991
  Lampson2007:
    title: Practical Principles for Computer Security
    author:
    - ins: B. Lampson
      name: Butler Lampson
    seriesinfo:
      IOSPress: Proceedings of Software System Reliability and Security
      page: 151-195
      DOI: 10.1.1.63.5360
    date: 2007
  iothreats:
    title: "The Internet of Things or the Internet of threats?"
    target: "https://gcn.com/articles/2016/05/03/internet-of-threats.aspx"
    author:
    - ins: GDN
      name: STEVE SARNECKI
    date: 2016
  RFC5209:
  RFC3552:
  RFC4949:
  I-D.richardson-rats-usecases: rats-usecases
  I-D.fedorkow-rats-network-device-attestation:
  keystore:
    target: "https://developer.android.com/training/articles/keystore"
    title: "Android Keystore System"
    author:
      ins: "Google"
      date: 2019
  fido:
    target: "https://fidoalliance.org/specifications/"
    title: "FIDO Specification Overview"
    author:
      ins: "FIDO Alliance"
      date: 2019

--- abstract

An entity (a relying party) requires a source of truth and evidence about a remote peer to assess the peer's trustworthiness. The evidence is typically a believable set of claims about its host, software or hardware platform. This document describes an architecture for such remote attestation procedures (RATS).

--- middle

# Introduction

Remote Attestation provides a way for an entity (the Relying Party) to determine the health and provenance of an endpoint (a host, or Attester).  Knowledge of the health of the entity, allows for a determination of trustworthiness of the endpoint.

## Motivation

The IETF has long spent it's time focusing on threats to the communication channel (see {{RFC3552}} and {{DOLEV-YAO}}), assuming that the end-points could be trusted, and were under the observation of a trusted, well-trained professional.
This assumption has not been true since the days of the campus mini-computer.
For some time after the desktop PC became ubiquitous the threat to the end-points has been dealt with as an internal matter, with generally poor results.
Enterprises have done some deployment of Network Endpoint Assessment ({{RFC5209}}) to assess the security posture about an endpoint (host), but it has not been ubiquitous.

The movement towards personal mobile devices ("smartphones") and the continuing threat from unmanaged residential desktops has resulted in a renewed interest in standardizing internet-scale end-point remote attestation.
Additionally, the rise of the Internet of Things (IoT) has made this issue even more critical: some skeptics have even renamed it to the Internet of Threats {{iothreats}} :-)  IoT devices have poor or non-existant user interfaces, so there are not even good ways to assess the health of the devices manually: a need to determine the health via remote attestation is now critical.

In addition to the health of the device, knowledge of its provenance helps to determine the level of trust, and prevents attacks to the supply chain.
<!--
[NED TO SUPPLY REFERENCES]
-->

## Opportunities

The Trusted Platform Module (TPM) is now a commonly available peripheral on many commodity compute platforms,  both servers and desktops.
Smartphones commonly have either an actual TPM, or have the ability to emulate one in software running in a trusted execution environment {{I-D.ietf-teep-architecture}}.  There are now few barriers to creating a standards-based system for remote attestation procedures.

A number of niche solutions have emerged that provide for use-case specific remote attestation, but none have the generality needed to be used across the Internet.

## Overview of Document

The architecture described in this document (along with the accompanying protocol implementation documents) enables the use of a common format for communicating Claims about an Attester to a Relying Party.

Existing transports were not designed to carry attestation Claims.  It is therefore necessary to design serializations of Claims that fit into a variety of transports, for instance: X509 certificates, TLS negotiations, or EtherNet/IP.  There are also new, greenfield uses for remote attestation. Transport and serialization of these can be done without retrofitting. This is described in [TBD].

While it is not anticipated that the existing niche solutions described in the use cases section will exchange claims directly, the use of a common format enables common code.
As some of the code needs to be in intentionally hard to modify trusted modules, the use of a common format significantly reduces the cost of adoption to all parties.
This commonality also significantly reduces the incidence of critical bugs.

In some environments the collection of Evidence by the Attester to be provided to the Verifier is part of an existing protocol: this document does not change that, rather embraces those legacy mechanisms as part of the specification.  This is an evolutionary path forward, not revolutionary.
Yet in other greenfield environments, there is a desire to have a standard for Evidence as well as for Attestation Results, and this architecture outlines how that is done.

This introduction gives an overview of the protocol, interaction models, messaging models and roles involved.
Following this, is a terminology section that is referenced normatively by other documents and is a key part of this document.
There is then a section on use cases and how they leverage the roles and workflows described.

In this document, terms defined within this document are consistently Capitalized [work in progress. please raise issues, if there are Blatant inconsistencies].

Current verticals that use remote attestation include:
* The Trusted Computing Group "Network Device Attestation Workflow" {{I-D.fedorkow-rats-network-device-attestation}}
* Android Keystore {{keystore}}
* Fast Identity Online (FIDO) Alliance attestation {{fido}}
* A number of Intel SGX niche systems based upon OTRP.

<!--
Things to be mentioned (XXX):
* Device Identifier Composition Engine (DICE)
* Time-based Uni-Directional Attestation (TUDA)
* TPM discussion
* Roots of Trust
-->

## RATS in a Nutshell

* Remote Attestation Interactions typically convey Claims that contain the trustworthiness properties associated with an Attested Environment (Evidence).
* A corresponding provisioning Interaction conveys Reference trustworthiness claims that can be compared with attestation Evidence. Reference Values typically consist of firmware or software digests and details about what makes the attesting module a trusted source of Evidence.
* Relying Parties are performing tasks such as managing a resource, controlling access, and/or managing risk. Attestation Results helps Relying Parties determine levels of trust.

## Remote Attestation Workflow

{:wholeflow: artwork-align="center"}
~~~~ WHOLEFLOW
{::include wholeflow.txt}
~~~~
{:wholeflow #wholeflow title="RATS Protocol Flows"}

In the RATS architecture shown above, specific content items (payload conveyed by Interactions) are identified:

* Evidence is as set of believable Claims about distinguishable Environments made by an Attester.
* Known-Good-Values are reference Claims used to appraise Evidence by an Verifier.
* Endorsements are reference Claims about the type of protection that enables an Attester to create believable Evidence. Endorsements enable trust relationships towards system components or environments Evidence cannot be created for by an Attester.
* Attestation Results are the output from the appraisal of Evidence, Known-Good-Values and Endorsements and are consumed by Relying Parties.

Attestation Results are the output of RATS.

Assessment of Attestation Results is be multi-faceted and out-of-scope for the RATS architecture.

If appropriate Endorsements about the Attester are available, Known-Good-Values about the Attester are available, and if the Attester is capable of creating believable Evidence - then the Verifier is able to create Attestation Results that enable Relying Parties to establish a level of confidence in the trustworthiness of the Attester.

The Asserter role and the format for Known-Good-Values and Endorsements are not subject to standardization at this time.  The current verticals already include provisions for encoding and/or distributing these objects.

## Interaction models
### Passport Model {#passport}

In the Passport Model Interaction Model the Attester provides it's Evidence directly to the Verifier.  The Verifier will evaluate the Evidence and then sign an Attestation Result.  This Attestation Result is returned to the Attester, and it is up to the Attester to communicate the Attestation Result (potentially including the Evidence, if disclosable) to the Relying Party.

{:passportflow: artwork-align="center"}
~~~~ PASSPORT
{::include passport-workflow.txt}
~~~~
{:passwordflow #passport_diag title="RATS Passport Flow"}

This flow is named in this way because of the resemblance of how Nations issue Passports to their citizens. The nature of the Evidence that an individual needs to provide to it's local authority is specific to the country involved.  The citizen retains control of the resulting document and presents it to other entities when it needs to assert a citizenship or identity claim.

### Background Check {#background}

In the Background-Check Interaction Model the Attester provides it's Evidence to the Relying Party.
The Relying Party sends this evidence to a Verifier of its choice.  The Verifier will evaluate the Evidence and then sign an Attestation Result.  This Attestation Result is returned to the Relying Party, which processes it directly.

{:passportflow: artwork-align="center"}
~~~~ BACKGROUND
{::include backgroundcheck-workflow.txt}
~~~~
{:passwordflow #background_diag title="RATS Background Check Flow"}

This flow is named in this way because of the resemblance of how employers and volunteer organizations
perform background checks.  When a prospective employee provides claims about education or previous experience, the employer will contact the respective institutions or former employers to validate the claim.  Volunteer organizations often perform police background checks on volunteers in order to determine the volunteer's trustworthiness.

# Terminology

{::boilerplate bcp14}

Appraisal:

: A Verifier process that compares Evidence to Reference values while taking into account Endorsements and produces Results.

Asserter:

: See {{asserter}}.

Attester:

: See {{attester}}.

Attested Environment:

: A target environment that is observed or controlled by an Attesting Environment.

Attesting Environment:

: An environment capable of making trustworthiness Claims about an Attested Environment.

Background-Check Interaction Model:

: An attestation workflow where the Attester provides Evidence to a Relying Party, who consults one or more Verifiers who supply Results to the Relying Party. See {{background}}.

Claim:

: A statement about the construction, composition, validation or behavior of an Entity that affects trustworthiness. Evidence, Reference Values and Results are expressions that consists of one or more Claims.
<!--
Statements about trustworthiness characteristics of an Attested Computing Environment. The veracity of a Claim is determined by the reputation of the entity making the Claim. Reputation may involve identifying, authenticating and tracking transactions associated with an entity. RATS may be used to establish entity reputation, but not exclusively. Other reputation mechanisms are out-of-scope.
-->

Conveyance:

: The process of transferring Evidence, Reference Values and Results between Entities participating in attestation workflow.

Entity:

: A device, component (see System Component {{RFC4949}}), or environment that implements one or more Roles.

Evidence:

: See {{evidence}}.

Passport Interaction Model:

: An attestation workflow where the Attester provides Evidence to a Verifier who returns Results that are then forwarded to one or more Relying Parties. See {{passport}}.

Reference Values:

: See {{reference}}. Also referred to as Known-Good-Values.

Relying Party:

: See {{relyingparty}}.

Results:

: See {{results}}.

Role:

: A function or process in an attestation workflow, typically described by: Attester, Verifier, Relying Party and Asserter.

Verifier:

: See {{verifier}}.

# Conceptual Overview

In network protocol exchanges, it is often the case that one entity (a Relying Party) requires an assessment of the trustworthiness of a remote entity (an Attester or specific system components {{RFC4949}} thereof).
Remote ATtestation procedureS (RATS) enable Relying Parties to establish a level of confidence in the trustworthiness of Attesters through the

* Creation,
* Conveyance, and
* Appraisal

of attestation Evidence.

Qualities of Evidence:

: Evidence is composed of Claims about trustworthiness. The number of Claims is not finite but continuously growing while technology advances. Additionally, the system characteristics of Attester, the Environments they are composed, and their continuous development have an impact on the veracity of trustworthiness Claims included in Evidence. Valid Evidence that includes trustworthy Claims about the intactness of an Attester must be impossible to create by an untrustworthy or compromised Environment of an Attester.

Qualities of Environments:

: The resilience of Environments that are part of an Attester can vary widely - ranging from those highly resistant to attacks to those having little or no resistance to attacks.
Configuration options, if set poorly, can result in a highly resistant environment being operationally less resistant.
When a trustworthy Environment changes, it is possible that it transitions from a trustworthy operational state to an untrustworthy operational state. An untrustworthy or compromised Environment must never be able to create valid Evidence expressing the intactness of an Attester.

The RATS architecture provides a framework for anticipating when a relevant change with respect to a trustworthiness attribute occurs, what exactly changed and how relevant it is. The RATS architecture also creates a context for enabling an appropriate response by applications, system software and protocol endpoints when changes to trustworthiness attributes do occur.

[FIXME suddenly - scope]
The scope of this document is based on Interaction Models and corresponding Roles based on the use cases defined in {{-rats-usecases}}.
Protocol specifications for Interaction Models are defined in separate documents.

## Two Types of Environments

An Attester produces Evidence about its own integrity, which means "it measures itself". To disambiguate this recursive or circular looking relationships, two types of Environments inside an Attester are distinguished:

The attest-ED Environments and the attest-ING Environments.

Attested Environments are measured. They provide the raw values and the information to be represented in Claims and ultimately expressed as Evidence.

Attesting Environments conduct the measuring. They collect the Claims, format them appropriately, and typically use key material and cryptographic functions, such as signing or cipher algorithms, to create Evidence.

Attesting Environments use system components that have to be trusted. As a result, Evidence includes Claims about the Attested and the Attesting Environments. Claims about the Attested Environments are appraised using Reference Values and Claims about the Attesting Environments are appraised using Endorsements. It is not mandated that both Environments have to be separate, but it is highly encouraged. Examples of separated Environments that can be used as Attesting Environments include: Trusted Execution Environments (TEE), embedded Secure Elements (eSE), or Hardware Security Modules (HSM).

In summary, the majority of the creation of evidence can take place in an Attested Environments. Exemplary duties include the collection and formatting of Claim values, or the trigger for creating Evidence. A trusted sub-set of the creation of evidence can take place in an Attesting Environment, that provide special protection with respect to key material, identity documents, or primitive functions to create the Evidence itself.

## Evidence Creation Prerequisites

One or more Environments that part of an Attester must be able to conduct the following duties in order to create Evidence:

* monitoring trustworthiness attributes of other Environments,
* collecting trustworthiness attributes and create Claims about them,
* serialize Claims using interoperable representations,
* provide integrity protection for the sets of Claims, and
* add appropriate attestation provenance attributes about the sets of Claims.

## Trustworthiness

The trustworthiness of an Attester and therefore the believability of the Evidence it creates relies on the protection methods in place to shield and restrict the use of key material and the duties conducted by the Attesting Environment. 
In order to assess trustworthiness effectively, it is mandatory to understand the trustworthiness properties of the environments of an Attester. The corresponding appraisal of Evidence that leads to such an assessment of trustworthiness is the duty of a Verifier.

Trusting the assessment of a Verifier might com frome trusting the Verifier's key material (direct trust), or trusting an Entity that the Verifier is associated with via a certification path (indirect trust).

The trustworthiness of corresponding Attestation Results also relies on trust towards manufacturers and those manufacturer's hardware in order to assess the integrity and resilience of that manufacturer's devices.

A stronger level of security comes when information can be vouched for by hardware or by ROM code, especially if such hardware is physically resistant to hardware tampering.
The component that is implicitly trusted is often referred to as a Root of Trust.

## RATS Workflow

The basic function of RATS is creation, conveyance and appraisal of attestation Evidence.
An Attester creates attestation Evidence that are conveyed to a Verifier for appraisal.
The appraisals compare Evidence with expected Known-Good-Values called obtained from Asserters (e.g. Principals that are Supply Chain Entities).
There can be multiple forms of appraisal (e.g., software integrity verification, device composition and configuration verification, device identity and provenance verification).
Attestation Results are the output of appraisals. Attestation Results are signed and conveyed to Relying Parties. Attestation Results provide the basis by which the Relying Party may determine a level of confidence to place in the application data or operations that follow.

RATS architecture defines attestation Roles (i.e., Attester, Verifier, Asserter and Relying Party), the messages they exchange, their structure and the various legal ways in which Roles may be hosted, combined and divided (see Principals below). RATS messages are defined by an information model that defines Claims, environment and protocol semantics. Information Model representations are realized as data structure and conveyance protocol binding specifications.

## Interoperability between RATS

The RATS architecture anticipates use of information modeling techniques that describe computing environment structures -- their components/computational elements and corresponding capabilities -- so that verification operations may rely on the information model as an interoperable way to navigate the structural complexity.

# RATS Architecture

## Goals

RATS architecture has the following goals:

* Enable semantic interoperability of attestation semantics through information models about computing environments and trustworthiness.
* Enable data structure interoperability related to claims, endpoint composition / structure, and end-to-end integrity and confidentiality protection mechanisms.
* Enable programmatic assessment of trustworthiness. (Note: Mechanisms that manage risk, justify a level of confidence, or determine a consequence of an attestation result are out of scope).
* Provide the building blocks, including Roles and Principals that enable the composition of service-chains/hierarchies and workflows that can create and appraise evidence about the trustworthiness of devices and services.
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

## Attestation Workflow

Attestation workflow helps a Relying Party make better decisions by providing insight about the trustworthiness of endpoints participating in a distributed system. The workflow consists primarily of four roles; Relying Party, Verifier, Attester and Asserter. Attestation messages contain information useful for appraising the trustworthiness of an Attester endpoint and informing the Relying Party of the appraisal result.

<!--
The RATS Roles (roles) are performed by RATS Principals.

The RATS Architecture provides the building blocks to compose various RATS roles by leveraging existing and new protocols. It defines architecture for composing RATS roles with principals and models their interactions.
-->
This section details the primary roles of an attestation workflow and the messages they exchange.

### Roles {#roles}

An endpoint system (a.k.a., Entity) may implement one or more attestation Roles to accommodate a variety of possible interaction models. Exemplary interaction models are described in {{passport}} and {{background}}. Role messages are secured by the Entity that generated it. Entities possess credentials (e.g., cryptographic keys) that authenticate, integrity protect and optionally confidentiality protect attestation messages.

#### Attester {#attester}

The Attester consists of both an Attesting Environment and an Attested Environment. In some implementations these environments may be combined. Other implementations may have multiples of Attesting and Attested environments. Although endpoint environments can be complex, and that complexity is security relevant, the basic function of an Attester is to create Evidence that captures operational conditions affecting trustworthiness.

<!--
...by collecting, formatting and protecting (e.g., signing) Claims.
It presents Evidence to a Verifier using a conveyance mechanism or protocol.

The creator of Evidence. The Role that designates an Entity to be assessed with respect to its trustworthiness properties in the scope of a specific Profile.
-->

#### Asserter {#asserter}

The Asserter role
In reality there are likely to be many Entities that implement the Asserter and many instances of Reference Value messages.
<!--
An Attestation Function that generates reference Claims about both the Attesting Computing Environment and the Attested Computing Environment.
The manufacturing and development processes are presumed to be trustworthy processes.
In other words the Asserter is presumed, by a Verifier, to produce valid Claims.
The function collects, formats and protects (e.g. signs) valid Claims known as Endorsements and Known-Good-Values.
It presents provable Claims to a Verifier using a conveyance mechanism or protocol.
-->
<!--
An Asserter is the origin of Endorsements and Known-Good-Values. The Role that designates an Entity that facilitates attestation provision workflows and potentially provides trust anchors.
-->

#### Verifier {#verifier}

The Verifier workflow function accepts Evidence from an Attester and accepts Reference Values from one or more Asserters. Reference values may be supplied a'priori, cached or used to created policies. The Verifier performs an appraisal by matching Claims found in Evidence with Claims found in Reference Values and policies. If an attested Claim value differs from an expected Claim value, the Verifier flags this as a change possibly impacting trust level.

Endorsements may not have corresponding Claims in Evidence (because of their intrinsic nature). Consequently, the Verifier need only authenticate the endpoint and verify the Endorsements match the endpoint identity.

The result of appraisals and Endorsements, informed by owner policies, produces a new set of Claims that a Relying Party is suited to consume.
<!--
An Attestation Function that accepts Evidence from an Attester using a conveyance mechanism or protocol.
It also accepts Known-Good-Values and Endorsements from an Asserter using a conveyance mechanism or protocol.
It verifies the protection mechanisms, parses and appraises Evidence according to good-known valid (or known-invalid) Claims and Endorsements.
It produces Attestation Results that are formatted and protected (e.g., signed).
It presents Attestation Results to a Relying Party using a conveyance mechanism or protocol.
-->
<!--
The consumer of Evidence for appraisal. The Role that designates an Entity to create Attestation Results based on Evidence, Known-Good-Values, and Endorsements.
-->

#### Relying Party {#relyingparty}

A Role in an attestation workflow that accepts Results from a Verifier that may be used by the Relying Party to inform application specific decision making. How Results are used to inform decision making is out-of-scope for this architecture.

<!--
It assesses Attestation Results protections, parses and assesses Attestation Results according to an assessent context (Note: definition of the assessment context is out-of-scope).

The consumer or proxy of Attestation Results. The Role that designates an Entity that requires reliable and believable statements about the Trustworthiness of an Attester Role.
-->

### Role Messages {#messages}

#### Evidence {#evidence}

Claims that are formatted and protected by an Attester.

Evidence SHOULD satisfy Verifier expectations for freshness, identity, context, provenance, validity, relevance and veracity.
<!--
 A Message type created and conveyed by the Attester Role. Attestation Evidence can be consumed and relayed by other Roles, primarily the Verifier Role to appraise the Evidence.
 -->

#### Reference Values {#reference}

Reference-values are Claims that a manufacturer, vendor or other supply chain entity makes that affects the trustworthiness of an Attester endpoint. Claims may be persistent properties of the endpoint due to the physical nature of how it was manufactured or may reflect the processes that were followed as part of moving the endpoint through a supply-chain; e.g., validation or compliance testing. This class of Reference-values is known as Endorsements. Another class of Reference-values identifies the firmware and software that could be installed in the endpoint after its manufacture. A digest of the the firmware or software can be an effective identifier for keeping track of the images produced by vendors and installed on an endpoint. This class of Reference-value is referred to as Known-Good-Value (KGV).

<!--
NMS What about calling them "Reference Digests"? This is more to the point of what it is.
-->

Known-Good-Values:

: Claims about the Attested Computing Environment. Typically, KGV Claims are message digests of firmware, software or configuration data supplied by various vendors.
If an Attesting Computing Environment implements cryptography, they include Claims about key material.

: Like Claims, Known-Good-Values SHOULD satisfy a Verifier's expectations for freshness, identity, context, provenance, validity, relevance and veracity.
Known-Good-Values are reference Claims that are - like Evidence - well formatted and protected (e.g. signed).
<!--
A Message type created and distributed by the Asserter Role and consumed by the Verifier Role. Known-Good-Values are reference Claims that are used to appraise the believability and veracity of attestation Evidence.
-->

Endorsements:

: Claims about immutable and implicit characteristics of the Attesting Computing Environment. Typically, endorsement Claims are created by manufacturing or supply chain entities.

: Endorsements are intended to increase the level of confidence with respect to Evidence created by an Attester.
<!--
A Message type created and distributed by the Asserter Role and consumed by the Verifier Role. Endorsements provide Claims about Components of an Attester that an Attesting Environment cannot create Evidence about.
-->

#### Results {#results}

Statements about the output of an appraisal of Evidence that are created, formatted and protected by a Verifier.

Attestation Results provide the basis for a Relying Party to establish a level of confidence in the trustworthiness of an Attester.
Attestation Results SHOULD satisfy Relying Party expectations for freshness, identity, context, provenance, validity, relevance and veracity.
<!--
A Message type created by the Verifier Role and ultimately consumed by Relying Parties.
-->

## RATS Principals

RATS Principals are entities, users, organizations, devices and computing environments (e.g., devices, platforms, services, peripherals).

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

RATS Evidence, Verifiable Assertions and Results SHOULD use formats that support end-to-end integrity protection and MAY support end-to-end confidentiality protection.
Replay attack prevention MAY be supported if a Nonce Claim is included.
Nonce Claims often piggy-back other information and can convey attestation semantics that are of essence to RATS, e.g. the last four bytes of a challenge nonce could be replaced by the IPv4 address-value of the Attester in its response.

All other attacks involving RATS structures are not explicitly addressed by RATS architecture.
Additional security protections MAY be required of conveyance mechanisms.
For example, additional means of authentication, confidentiality, integrity, replay, denial of service and privacy protection of RATS payloads and Principals may be needed.
