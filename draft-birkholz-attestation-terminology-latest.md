---
title: Reference Terminology for Attestation Procedures
abbrev: term-attestation
docname: draft-birkholz-attestation-terminology-latest
wg: 
stand_alone: true
ipr: trust200902
area: Security
kw: Internet-Draft
cat: info
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

normative:
  RFC2119:

informative:

--- abstract 

Please help me to become a concise abstract!

--- middle

# Introduction

Over the years, the term attestation has been used in multiple contexts and multiple scopes and therefore accumulated various connotations with slightly different semantic meaning.

In order to better understand and grasp the intend and meaning of specific attestation procedures in the security area - including the requirements that are addressed by them - this document provides an overview of existing work, its background, and common terminology. As the contribution, from that state-of-the-art a set of terms that provides a stable basis for future work on attestation procedures in the IETF is derived.

The primary application of attestation procedures is to increase the trust and confidence in characteristics or specific attributes about two parties that intend to exchange data. How a party’s characteristics are attested and which characteristics are actually chosen to be attested varies with the requirements, or – in essence – the risk that is intended to be mitigated. It is important to note that the activity of attestation itself in principle only provides a reliable basis for further activities that provide the semantic context of what an attestation procedures actually accomplishes and what it cannot. Hence, this document is also intended to provide a map of terms, concepts and applications that illustrates the ecosystem of current applications of attestation procedures.

Before an adequate set of terms and definitions for the attestation domain can be defined, a general understanding and global definitions of the “what” and the “how” have to be established. In consequence, [enter final structure here].

## Requirements notation

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in RFC
2119, BCP 14 {{RFC2119}}.

# Basic Attestation Roles

The use of the term attestation always implies the involvement of at least two parties that each take on a specific role in corresponding procedures – the attestee role and the verifier role. Depending on the characteristics attested and the nature of the parties, information is exchanged via specific types of interconnects between them. The type of interconnect ranges from GIO pins, to a bus, to the Internet, or from a direct physical connection, to a wireless association, to a world wide mesh of peers. In other words, virtually every kind communication path can be used by the two roles. In fact, a single party can take on both roles at the same time, but there is only a limited use to this architecture.

Attestee:

: The role that designates the subject of the attestation

Verfifier:

: The role that designates the appraiser of the attestee’s attestation

Interconnect:

: A channel of communication between attestee and verifier that enables the appraisal of the attestee’s attestation.

# Computing Context

This section introduces the term computing context in order to simplify the definition of attestation terminology.

The number of approaches and solutions to create things that provide the same capabilities as a “simple physical device” continuously increases. Examples include but are not limited to: the compartmentalization of physical resources, the separation of software instances with different dependencies in dedicated containers, and the nesting of virtual components via hardware-based and software-based solutions.

In essence, every physical device is a composite of components that are potential computing contexts capable of taking on the roles of attestee or verifier. The scope and application of these roles can range from continuous mutual attestation of every component in the hierarchy of the composite that constitutes a single distinguishable endpoint on the management plane, to sporadic attestation of the integrity of an experiment in earth orbit.

Analogously, the increasing number of features and functions start to blur the lines that are required to categorize each solution and approach precisely. To address that increasingly difficult categorization, the term computing context defines the characteristics of the entities that can take on the role of an attestee – and in consequence the role of a verifier. This approach is intended to provide a stable basis of definitions for future solutions that continuous to remain viable long-term.

Computing context is an umbrella term that combines the scope of the definitions of endpoint [ref NEA], device [ref 1ar], and thing [ref t2trg], including hardware-based and software-based sub-contexts that constitute independent and distinguishable slices of a computing context created by compartmentalization mechanisms, such as trusted execution environments or virtual network security function contexts.

## Formal Semantic Relationships

The formal semantic relationship of a computing context and the definitions provided by RFC 4949 is a as follows.

A computing context:
* is a specific information system
* is an object and in consequence a system component
* is a composite of system entities

Analogously, a sub-context is a subsystem and as with system components, computing contexts can be nested and therefore be physical system components or logical (“virtual”) system components.

The formal semantic relationship is based on the following definitions from RFC 4949.

(Information) System:

: An organized assembly of computing and communication resources and procedures -- i.e., equipment and services, together with their supporting infrastructure, facilities, and personnel -- that create, collect, record, process, store, transport, retrieve, display, disseminate, control, or dispose of information to accomplish a specified set of functions.

Object:

: A system component that contains or receives information.

Subsystem:

: A collection of related system components that together perform a system function or deliver a system service.

System Component:

: A collection of system resources that (a) forms a physical or logical part of the system, (b) has specified functions and interfaces, and (c) is treated (e.g., by policies or specifications) as existing independently of other parts of the system. (See: subsystem.)

: An identifiable and self-contained part of a Target of Evaluation.

System Entity:

: An active part of a system -- [...] (see: subsystem) -- that has a specific set of capabilities.

## Characteristics of a computing context

While the semantic relationships highlighted above constitute the fundamental basis to define the context of computing context, the following list of characteristics is intended to improve the intuitive understanding of the term and provide a better understanding of its meaning:

A computing context:

* creates its own independent environment in regard to executing and running software,
* creates its own separate control plane state (by potentially interacting with other computing contexts) and can provide a dedicated management interface by which control plane behavior can be effected,
* can be identified uniquely and therefore reliably differentiated in a given scope, and
* does not necessarily has to include a network interface with associated network addresses (as required, e.g. by the definition of an endpoint) – although it is very likely to have (access to) one.

In contrast, a docker [ref docker, find a more general term here] context is not a distinguishable slice of a computing system and therefore is not an independent computing context.

Examples include: a smart phone, a nested virtual machine, a virtualized firewall function running distributed on a cluster of physical and virtual nodes, or a trust-zone.

# Attestation Workflow

This section introduces terms and definitions that are required to illustrate the scope and the granularity of attestation workflows in the context of security automation. Terms defined in the following sections will be based on this workflow-related definitions.

In general, attestation is an iterative procedure that is conducted over and over again in a computing context under specific conditions. It is neither a generic set of actions nor simply a task, because the actual actions to be undertaken in order to conduct an attestation procedure can vary significantly depending on the protocols employed and types of computing contexts involved.

Activity:

: The condition in which things are happening or being done. In the scope of attestation, an activity is a sequence of actions that is intended to produce a specifically defined result. The actual composition of actions can vary, depending on the characteristics of the computing context they are conducted by/in and te protocols used.

Example: The conveyance of cryptographic evidence is an activity or the acquisition of an trusted time stamp token are activities.

Task:

: A piece of work to be done or undertaken. In the scope of attestation, a task is a procedure to be conducted.

Example: A Verifier can be tasked with the appraisal of evidence originating from a specific type of computing contexts.

Action:

: The accomplishment of a thing usually over a period of time, in stages, or with the possibility of repetition. In the scope of attestation, an action is the execution of an operation or function in the scope of an activity conducted by a single computing context.

Example: Signing an existing public key via a specific openssl library, transmitting data, or receiving data are actions.

Procedure:

: A series of actions that are done in a certain way or order. In the scope of attestation, a procedure is a composition of activities (sequences of actions) that is intended to create a well specified result.

Example: The activities of attestation, conveyance and verification compose a remote attestation procedure.
# Attestee Reference Use Cases

This document provides NNN prominent examples of use cases attestation procedures are intended to address:

* proofing the source integrity of a computing context by proofing the data integrity of installed software instances that are executed, and
* identity proofing a computing context.

These use case summary highlighted above is based in the follow terms defined in RFC4949:

Identity:

: 

Identity Proofing:

: A process that vets and verifies the information that is used to establish the identity of a system entity.

Source Integrity:

: The property that data is trustworthy (i.e., worthy of reliance or trust), based on the trustworthiness of its sources and the trustworthiness of any procedures used for handling data in the system.

Data Integrity:

: 1. The property that data has not been changed, destroyed, or lost in an unauthorized or accidental manner. (See: data integrity service. Compare: correctness integrity, source integrity.)

: 2. The property that information has not been modified or destroyed in an unauthorized manner.

Correctness:

: The property of a system that is guaranteed as the result of formal verification activities.

Correctness integrity:

: The property that the information represented by data is accurate and consistent. 

Verification:

: 1. The process of examining information to establish the truth of a claimed fact or value.

: 2. The process of comparing two levels of system specification for proper correspondence, such as comparing a security model with a top-level specification, a top-level specification with source code, or source code with object code.

## The Lying Endpoint Problem

A very prominent goal of attestation procedures – and therefore a suitable example used as reference in this document - is to address the “lying endpoint problem”.

Information created, relayed, or, in essence, emitted by a computing context does not have to be correct. There can be multiple reasons why that is the case and the “lying endpoint problem” represents a scenario, in which the reason is the compromization of computing contexts with malicious intend. A compromised computing context could try to “pretend” to be integer, while actually feeding manipulated information into a security domain, therefore compromising the effectiveness of automated security functions. Attestation – and remote attestation procedures specifically – is an approach intended to identify compromised software instances in computing contexts.

Per definition, a “lying endpoint” cannot be “trusted system”.

Trusted System:

: A system that operates as expected, according to design and policy, doing what is required -- despite environmental disruption, human user and operator errors, and attacks by hostile parties -- and not doing other things.

Remote attestation procedures are intended to enable the consumer of information emitted by an computing context to assess the validity and integrity of the information transferred. The approach is based on the assumption that if evidence can be provided in order to prove the integrity of every software instance installed involved in the activity of creating the emitted information in question, the emitted information can be considered valid and integer.

In contrast, such evidence has to be impossible to create if the software instances used in a computing context are compromised. Attestation activities that are intended to create this evidence therefore also to also provide guarantees about the validity of the evidence they can create.

# Trustworthiness

A “lying endpoint” is not trustworthy. 

Trusted System:

: A system that operates as expected, according to design and policy, doing what is required -- despite environmental disruption, human user and operator errors, and attacks by hostile parties -- and not doing other things.

Trustworthy:

: pull in text here

#  IANA considerations

This document will include requests to IANA:

* first item
* second item

#  Security Considerations

There are always some.

#  Acknowledgements

Maybe.

#  Change Log

No changes yet.

--- back
