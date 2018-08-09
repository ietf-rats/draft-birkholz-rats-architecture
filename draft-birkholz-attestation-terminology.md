---
title: Reference Terminology for Remote Attestation Procedures
abbrev: RATS Terminology
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
  RFC4949:

informative:
  I-D.ietf-sacm-terminology: sacmterm
  RFC7519: jwt

--- abstract

This document is intended to illustrate and remediate the impedance mismatch of terms related to
Remote Attestation procedures used in different domains today. New terms defined by this document
provide a consolidated basis to support future work on Attestation procedures in the IETF and
beyond.

--- middle

# Introduction

During its evolution, the term Remote Attestation has been used in multiple contexts and multiple
scopes and in consequence accumulated various connotations with slightly different semantic meaning.
Correspondingly, Remote Attestation Procedures (RATS) are employed in various usage scenarios and
different environments.

In order to better understand and grasp the intend and meaning of specific RATS in the scope of the
security area - including the requirements that are addressed by them - this document provides an
overview of existing work, its background, and common terminology. As the contribution, from that
state-of-the-art a set of terms that provides a stable basis for future work on RATS in the IETF is
derived.

The primary application of RATS is to increase the trust and confidence in the integrity of the
object characteristics and properties of a system entity that is intended to interact and exchange
data with other system entities remotely. How an objects’s characteristics are attested remotely and
which characteristics are actually chosen to be attested varies with the requirements of the use
cases, or -– in essence –- depends on the risk that is intended to be mitigated via RATS.
Effectively, RATS are a vital tool to be used to increase the confidence in the level of trust of a
system that is supposed to be a trusted system.

In the remainder of this document a system that is capable to provide an appropriate amount of
information about its integrity is considered to be a trustworthy system - or simply trustworthy.

The primary characteristics of a trustworthy system are commonly based on information about the
integrity of its intended composition, its enrolled and subsequently installed software components,
and the scope of known valid states that a trustworthy system is supposed to operate in.

It is important to note that the Activity of Attestation itself in principle only provides the
Evidence that proves the integrity of a (subset) of a system's object characteristics. The provided
Evidence is used as a basis for further activities. Specific RATS define the higher semantic context
about how the Evidence is utilized and what RATS actually can accomplish; and what they cannot
accomplish, correspondingly. Hence, this document is also intended to provide a map of terms,
concepts and applications that illustrate the ecosystem of current applications of RATS.

In essence, a prerequisite for providing an adequate set of terms and definitions in the domain of
RATS is a general understanding and a common definitions of “what” RATS can accomplish “how” RATS
can to be used.

Please note that this document is still missing multiple reference and is considered "under
construction". The majority of definitions is still only originating from IETF work. Future
iterations will pull in more complementary definitions from other SDO (e.g. Global Platform, TCG,
etc.) and a general structure template to highlight semantic relationships and capable of resolving
potential discrepancies will be introduced. A section of context awareness will provide further
insight on how Attestation procedures are vital to ongoing work in the IETF (e.g. I2NSF & tokbind).
The definitions in the section about RATS are still self-describing in this version. Additional explanatory text will be added to provide more context and coherence.

## Requirements notation

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in RFC
2119, BCP 14 {{RFC2119}}.

## Terminology

This document relies on terminology found in [RFC4949](tools.ietf.org/html/rfc4949). This document presumes the reader is familiar with the following terms.

+ Cryptography
+ Entity (System entity)
+ Identity
+ Object
+ Principal
+ Proof-of-possession protocol
+ Security environment (Environment)
+ Security perimeter
+ Subject
+ Subsystem
+ System
+ Target-of-Evaluation (TOE)
+ Trust
+ Trusted Computing Base (TCB)
+ Trusted Platform Module (TPM)
+ Trusted (Trustworthy) system
+ Verification

Terminology defined by this document is preceded by a dollar sign ($) to distinguish it from terms defined elsewhere and as a way to disambiguate term definition from explanatory text.

Terms defined by this document that are subsequently used by this document are distinguished by capitalizing the first letter of the term (e.g. Term or First_word Second_word).

# The Lying Endpoint Problem

A very prominent goal of Remote Attestation is to address the “lying endpoint problem”. The lying endpoint problem is characterized as a condition of a Computing Context where the information or behavior embedded, created, relayed, stored, or emitted by the Computing Context is not "correct" according to expectations of the authorized system designers, operators and users. There can be multiple reasons why these expectations are incorrect, either from malicious Activity, unanticipated conditions or accidental means. The observed behavior, nevertheless appears to be a compromised Computing Context.

Attempts to "scrub" the data or "proxy" control elements implies the existence of a more fundamental trusted endpoint that is operating correctly. Therefore, Attestation - the technology designed to detect and mitigate the "lying endpoint problem" – must be trusted to behave correctly independent of other controls.

Consequently, a “lying endpoint” cannot also be a “trusted system”.

Remote Attestation procedures are intended to enable the consumer of information emitted by an Computing Context to assess the validity and integrity of the information transferred. The approach is based on the assumption that if Evidence can be provided in order to prove the integrity of every software instance installed involved in the Activity of creating the emitted information in question, the emitted information can be considered valid and integer.

In contrast, such Evidence has to be impossible to create if the software instances used in a Computing Context are compromised. Attestation activities that are intended to create this Evidence therefore also to also provide guarantees about the validity of the Evidence they can create.

## Attestation asks the question "Who am I a talking to"?

[working title, write up use case here, ref teep requirements]

# What are Remote Attestation Procedures (RATS)?

Remote Attestation Procedures implies the involvement of at least two principles who seek to overcome the lying endpoint problem. The Verifier wishes to consume application data supplied by an a Computing Context. But before application data is consumed, the Verifier obtains Evidence about the Computing Context to assess likelihood of poisoned data due to endpoint compromise or failure. There is at least one principal known as the Claimant that asserts the Computing Context possesses certain integrity properties. A communication endpoint known as the Attestor conveys Evidence of Computing Context integrity properties to the Verifier as part of a protocol known as Remote Attestation.

Attestation argues that an object's integrity characteristics should not be believed until rationale for believability is presented to the subject seeking to interact with the object.

An Interconnect defines an untrusted channel between subject and object wherein the rationale for believability is securely exchanged. The type of interconnect technology could vary widely, ranging from GPIO pins, to a PC peripheral IO bus, to the Internet, to a direct physical connection, to a wireless radio-receiver association, or to a world wide mesh of peers. In other words, virtually every kind communication path could be used as the "Interconnect" component of a Remote Attestation system. In fact, a single party can take on both roles at the same time.

Attestation _Evidence_ can be thought of as the topics of the exchange. Evidence may be structured in an interoperable format called Claims that may include references to Claimants who are the entities asserting the Claims. RATS aims to define "interoperable Remote Attestation" such that Evidence can be created and consumed by different ecosystem entities and can be securely exchanged by a broad set of protocols.

## Fundamental Roles in RATS

$ Claimant:

: An ecosystem entity that asserts Attestable Claims. Ideally there is a _most authoritative Claimant_ or a _consensus of Claimants_ who are in the best position to make believable Claims. For example the person who wrote a software package may be in the best position to describe how the package works or is intended to work.

$ Attestor:

: A system entity that supplies Evidence in the form of Attestable Claims and who establishes the Attestor role and endpoint. The Attestor may also be a Claimant.

$ Verifier:

: A system entity that appraises Attestable Claims provided by the Attestor, establishes the Verifier role and endpoint. The Verifier may also be a Claimant.

$ Interconnect:

: A channel of communication established between Attestor and Verifier that enables the appraisal of Attestable Claims.

# Computing Context

This section introduces the term Computing Context in order to specialize the notions of environment and endpoint to terminology that has relevance to trusted computing. Attestation is a discipline of trusted computing.

A Computing Context could refer to a large variety of endpoints. Examples include but are not limited to: the compartmentalization of physical resources, the separation of software instances with different
dependencies in dedicated containers, and the nesting of virtual components via hardware-based and
software-based solutions. The number of approaches and techniques to construct an endpoint continuously changes with new innovation. Hence, it isn't a goal of this document to define remote attestation for a fixed set of endpoints. Rather, it attempts to define endpoints conceptually and rely on Claims management as a way to clarify the details and specific attributes of conceptual endpoints.

Computing Contexts may be recursive in nature in that it could be composed of a system entity that is itself a composite of system entities. In consequence, a system entity may be composed of other system entities that may be further composed of one or more Computing Contexts capable of taking on the roles of
Attestor, Verifier or Claimant. The scope and application of these roles can range from:

* Continuous mutual Attestation procedures of every system entity inside a composite device, to
* Sporadic Remote Attestation of unknown parties via heterogeneous Interconnects.

Analogously, the increasing number of features and functions that constitute components of a device
start to blur the lines that are required to categorize each solution and approach precisely. To
address this increasingly challenging categorization, the term Computing Context defines the
characteristics of the system entities that can take on the role of an Attestor and/or the role of a
Verifier. This approach is intended to provide a stable basis of definitions for future solutions
that continuous to remain viable long-term.

$ Computing Context :

: An umbrella term that combines the scope of the definitions of endpoint [ref NEA], device [ref
1ar], and thing [ref t2trg], including hardware-based and software-based sub-contexts that
constitute independent, isolated and distinguishable slices of a Computing Context created by
compartmentalization mechanisms, such as Trusted Execution Environments (TEE), Hardware Security
Modules (HSM) or Virtual Network Function (VNF) contexts.

## Characteristics of a Computing Context

While the semantic relationships highlighted above constitute the fundamental basis to provide a
define Computing Context, the following list of object characteristics is intended to improve the
application of the term and provide a better understanding of its meaning:

$ Computing Context Characteristics:

: A representation of the identity, composition, configuration and state of a Computing Context.

: Computing context characteristics provide the following:
* An independent environment in regard to executing and running software,
* An isolated control plane state (by potentially interacting with other Computing Contexts),
* A dedicated management interface by which control plane behavior can be effected,
* Unique identification towards reliable disambiguation within a given scope.

Computing context characteristics do not necessarily include a network interface with associated network addresses (as required by the definition of an endpoint) – although it is very likely to have (access to) one.

<NMS: I'm not sure I agree with this conclusion> In contrast, a container [ref docker, find a more general term here] context is not a distinguishable
isolated slice of an information system and therefore is not an independent Computing Context. [more
feedback on this statement is required as the capabilities of docker-like functions evolve
continuously]

Examples include: a smart phone, a nested virtual machine, a virtualized firewall function running distributed on a cluster of physical and virtual nodes, or a trust-zone.

## Computing Context Semantic Relationships

Computing Contexts may relate to other Computing Contexts that are decomposable in a variety of ways.

+ Singleton,
+ Tuples (e.g. 2-tuple, n-tuple),
+ Nested,
+ Clustered (homogeneous),
+ Grouped (heterogenous).

The scope of Computing Context encompasses a broad spectrum of systems including, but not limited to:

+ An information system,
+ An object,
+ A composition of objects,
+ A system component,
+ A system sub-component,
+ A composition of system sub-components,
+ A system entity,
+ A composition of system entities.

A Computing Context may be realized in a variety of ways including, but not limited to:

+ A process, thread or task as defined by an operating system,
+ A privileged operating system task, interrupt handler or event handler,
+ A virtual machine,
+ A virtual machine monitor,
+ A processor mode (e.g. system management mode),
+ A co-processor,
+ A peripheral device,
+ A secure element,
+ A trusted execution environment,
+ A controller, sensor, actutor, switch, router or gateway,
+ An FPGA,
+ An ASIC,
+ A memory resource,
+ A storage resource.

Analogously, a computing sub-context is a decomposition of a Computing Context; a subsystem is a decomposition of a system; a sub-component is a decomposition of a component; and a peer node is a decomposition of a node cluster.

A formal semantic relationship is therefore expressed using an information model that captures interactions, relationships, bindings and interfaces among systems, subsystems, system components, system entities or objects.

An information model that richly captures Computing Context semantics is therefore believed to be relevant if not fundamental to Remote Attestation.

## Computing Context Identity

The identity of a Computing Context implies there is a binding operation between an identifier and the Computing Context.

$ Computing Context Identity:
: Computing Context Identity provides the basis for associating Evidence about a particular Computing Context.

Confidence in the identity assurance level [NIST SP-800-63-3] or the assurance levels for identity authentication {{RFC4949}} is a property of the identifier uniqueness properties and binding operation veracity. Such properties impact the trustworthiness of associated Evidence.

# Attestation Concepts

Attestation is a form of telemetry about a computing environment that enables better security risk management through disclosure of security properties of the environment. Attestation may be performed locally (within the same computing environment) or remotely (between different computing environments). The exchange of Attestation information can be formalized to include well-defined protocol, message syntax and semantics.

## Attestation Definition

$ Attestation:

: A form of telemetry involving the delivery of Claims describing various security properties of a Computing Context by an Attestor, such that the Claims can be used as Evidence toward convincing a Verifier regarding trustworthiness of the Computing Context.

$ Conveyance:

: The transfer of Evidence from the Attestor to the Verifier.

$ Verification:

: The appraisal of Evidence by the Verifier who evaluates it against a reference policy. See also [RFC4949](https://tools.ietf.org/html/rfc4949).

$ Remote Attestation:

: A procedure involving Attestation, Conveyance and Verification.

## Attestation Information Model

Evidence conveyed to a Verifier by an Attestor is structured to facilitate syntactic and semantic interoperability. An information model defines the tag namespaces used to create tag-value pairs containing discrete bits of Evidence.

$ Evidence:

: A set of Measurements, quality metrics, quality procedures or assurance criteria about an Computing Context's behavioral, operational and intrinsic characteristics.

$ Claim:

: Structured Evidence asserted about a Computing Context. It contains metadata that informs regarding the type, class, representation and semantics of Evidence information. A Claim is represented as a name-value pair consisting of a Claim Name and a Claim Value {{-jwt}}. In the context of SACM, a Claim is also specialized as an attribute-value pair that is intended to be related to a statement {{-sacmterm}}.

$ Attestable Claim:

: Structured Evidence including one or more Claims that are asserted by a Claimant (Note: an Attestor role doubles as a Claimant role). An Attestable Claim has the following structure:

1. A Claim or Claims.
2. A Claimant identity.
3. Proof of Claimant identity.
4. Proof the Claimant intended to make these Claims.

Note: Proofs of Claims assertions may be separated from the Claim itself. For example, a secure transport over which Claims are conveyed where Claimant's signing key integrity protects the transport payload could be used as proof of Claim assertion. Alternatively, each Claim could be separately signed by a Claimant.

$ Attested (Asserted) Claim:

: An Attestable Claim where the proof elements are populated.

$ Evidence (Claims) Creation:

: Instantiation of Attested Claims by a Claimant.

$ Evidence (Claims) Collection:

: Assembling of Attested Claims by an Attestor for the purpose of Conveyance.

$ Verified (Valid) Claim:

: An Attested Claim where the proof elements have been verified by a Verifier according to a policy that identifies trusted Claimants and/or trusted Evidence values.

## Attestation Workflow

This section introduces terms and definitions that are required to illustrate the scope and the
granularity of RATS workflows in the domain of security automation. Terms defined in the following sections will be based on this workflow-related definitions.

In general, RATS are composed of iterative activities that can be conducted in intervals. It is
neither a generic set of actions nor simply a task, because the actual actions to be conducted by
RATS can vary significantly depending on the protocols employed and types of Computing Contexts
involved.

$ Activity:

: A sequence of actions conducted by Computing Contexts that compose a Remote Attestation procedure. The actual composition of actions can vary, depending on the characteristics of the Computing
Context they are conducted by/in and the protocols used to utilize an Interconnect. A single
Activity provides only a minimal amount of semantic context, e.g.defined  by the Activity's
requirements imposed upon the Computing Context, or via the set of actions it is composed of.
Example: The Conveyance of cryptographic Evidence or the appraisal of Evidence via imperative
guidance.

$ Task:

: A unit of work to be done or undertaken.

: In the scope of RATS, a task is a procedure to be conducted. Example: A Verifier can be tasked
with the appraisal of Evidence originating from a specific type of Computing Contexts providing
appropriate identities.

$ Action:

: The accomplishment of a thing usually over a period of time, in stages, or with the possibility
of repetition.

: In the scope of RATS, an action is the execution of an operation or function in the scope of an
Activity conducted by a Computing Context. A single action provides no semantic context by itself,
although it can limit potential semantic contexts of RATS to a specific scope. Example: Signing an
existing public key via a specific openssl library, transmitting data, or receiving data are
actions.

$ Procedure:

: A series of actions that are done in a certain way or order.

: In the scope of RATS, a procedure is a composition of activities (sequences of actions) that is
intended to create a well specified result with a well established semantic context.
Example: The activities of Attestation, Conveyance and Verification compose a Remote Attestation procedure.

## Attestation Use Cases

A “lying endpoint” is not trustworthy.

This document provides NNN prominent examples of use cases Attestation procedures are intended to address:

* Verification of the source integrity of a Computing Context via data integrity proofing of installed software instances that are executed, and
* Verification of the identity proofing of a Computing Context.

### Use Case A

### Use Case B

# Attestation and Trusted Computing Vocabulary

$ Attestable Computing Context:

: A Computing Context where a Claimant is able to create Claims, an Attestor is able to Attest those Claims and a Verifier is able to verify the Claims.

$ Attestation Identity:

: An identity that refers to an Attestor.

$ Attestation Identity Credential:

: A credential used to authenticate an Attestation Identity.

$ Attestation Identity Key (AIK):

: An Attestation Identity Credential in the form of an asymmetric cryptographic key where the AIK private key is protected by a Computing Context with protection properties that are stronger than the Computing Context about which the AIK attests. A root-of-trust Computing Context normally protects AIK private keys.

$ Claimant Identity:

: An identity that refers to an Claimant.

$ Claimant Identity Credential:

: A credential used to authenticate a Claimant Identity.

$ Measurements / Integrity Measurements:

: Metrics of Computing Context characteristics (i.e. composition, configuration and state) that affect the confidence in the trustworthiness of a Computing Context. Digests of integrity Measurements can be stored in shielded locations (e.g. a PCR of a TPM).

$ Reference Integrity Measurements:

: Signed Measurements about a Computing Context's characteristics that are provided by a vendor or manufacturer and are intended to be used as declarative guidannce {{-sacmterm}} (e.g. a signed CoSWID).

$ Root-of-trust:

: The Computing Context that protects the following where no other Computing Context is expected to provide its Attestation Evidence:
+ Attestation Evidence.
+ AIKs.
+ Code used during the collection and reporting of Attestation Evidence.

$ Root-of-trust-for-measurement (RTM):

: A trusted Computing Context where a Claimant creates integrity Measurements and other Evidence about a Computing Context where no other Computing Context is expected to provide its Attestation Evidence.

$ Root-of-trust-for-reporting (RTR):

: A trusted Computing Context where an Attestor stages reporting of Claims where no other Computing Context is expected to provide its Attestation Evidence.

$ Root-of-trust-for-storage (RTS):

: A trusted Computing Context where a Claimaint or Attestor stores Claims, Evidence, credentials or policies associated with Attestation where no other Computing Context is expected to provide its Attestation Evidence.

$ Trustworthiness:

: The qualities of Computing Context characteristics that guarantee a specific behavior specified by declarative guidance. Trustworthiness is not an absolute property but defined with respect to a Computing Context, corresponding declarative guidance, and has a scope of confidence. A trusted system is trustworthy. [See also Trustworthy System](https://tools.ietf.org/html/rfc4949)

$ Trustworthy Computing Context:

: A Computing Context that guarantees trustworthy behavior and/or composition (with respect to certain declarative guidance and a scope of confidence). A trustworthy Computing Context is a trusted system.

<NMS: is this necessary?> Trustworthy Statement:

: Evidence conveyed by a Computing Context that is not necessarily trustworthy. [update with tamper related terms]

## Interpretations of RFC4949 Terminology for Attestation

Assurance:
: An attribute of an information system that provides grounds for having confidence that the system
operates such that the system's security policy is enforced [RFC4949] (see Trusted System below).

: In common criteria, assurance is the basis for the metric level of assurance, which represents the
"confidence that a system's principal security features are reliably implemented".

: The NIST Handbook [get ref from 4949] notes that the levels of assurance defined in Common Criteria
represent "a degree of confidence, not a true measure of how secure the system actually is. This
distinction is necessary because it is extremely difficult--and in many cases, virtually
impossible--to know exactly how secure a system is."

: Historically, assurance was well-defined in the Orange Book
[http://csrc.nist.gov/publications/history/dod85.pdf] as "guaranteeing or providing
confidence that the security policy has been implemented correctly and that the protection-relevant
elements of the system do, indeed, accurately mediate and enforce the intent of that policy.  By
extension, assurance must include a guarantee that the trusted portion of the system works only as
intended."

Confidence:

: The definition of correctness integrity in [RFC4949] notes that "source integrity refers to
confidence in data values".
Hence, confidence in an Attestation procedure is referring to the degree of trustworthiness of an
Attestation Activity that produces Evidence (Attestor), of an Conveyance Activity that transfers
Evidence (interconnect), and of a Verification Activity that appraises Evidence (Verifier), in respect to correctness integrity.

Correctness:

: The property of a system that is guaranteed as the result of formal Verification activities.

Correctness integrity:

: The property that the information represented by data is accurate and consistent.

Data Integrity:

: (a) The property that data has not been changed, destroyed, or lost in an unauthorized or accidental manner. (See: data integrity service. Compare: correctness integrity, source integrity.)

: (b) The property that information has not been modified or destroyed in an unauthorized manner.

Entity:

: A principal, Subject, relying party or stake holder in an Attestation ecosystem.

Identity:

: The set of attributes that distinguishes a principal.

Identifier:

: The set of attributes that distinguishes an object.

Identity Proofing:

: A vetting process that verifies the information used to establish the identity of a system entity.

(Information) System:

: An organized assembly of computing and communication resources and procedures -- i.e., equipment and services, together with their supporting infrastructure, facilities, and personnel -- that create, collect, record, process, store, transport, retrieve, display, disseminate, control, or dispose of information to accomplish a specified set of functions.

Object:

: A system component that contains or receives information.

Source Integrity:

: The property that data is trustworthy (i.e., worthy of reliance or trust), based on the trustworthiness of its sources and the trustworthiness of any procedures used for handling data in the system.

Subject:

: A Computing Context acting in accordance with the interests of a principal.

Subsystem:

: A collection of related system components that together perform a system function or deliver a system service.

System Component:

: An instance of a system resource that (a) forms a physical or logical part of the system, (b) has specified functions and interfaces, and (c) is extant (e.g., by policies or specifications) outside of other parts of the system. (See: subsystem.)

: An identifiable and self-contained part of a $Target-of-Evaluation.

Token:

: A data structure suitable for containing Claims.

Trusted (Trustworthy) System:

: A system that operates as expected, according to design and policy, doing what is required -- despite environmental disruption, human user and operator errors, and attacks by hostile parties -- and not doing other things.

Verification:

: (a) The process of examining information to establish the truth of a claimed fact or value.

: (b) The process of comparing two levels of system specification for proper correspondence, such as comparing a security model with a top-level specification, a top-level specification with source code, or source code with object code.

## Building Block Vocabulary (Not in RFC4949)

[working title, pulled from various sources, vital]

Attribute:

: TBD

Characteristic:

: TBD

Context:

: TBD

Endpoint:

: TBD

Environment:

: TBD

Manifest:

: TBD

Telemetry:

: An automated communications process by which data, readings, Measurements and Evidence are collected at remote points and transmitted to receiving equipment for monitoring and analysis. Derived from the Greek roots tele = remote, and metron = measure. [See Wikipedia](https://en.wikipedia.org/wiki/Telemetry).


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
