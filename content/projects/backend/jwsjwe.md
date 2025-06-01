+++
title = "JSON Web Signature & JSON Web Encryption"
authors = ["Shane Oatman"]
description = "Introduction to the JWS and JWE libraries."
keywords = ["JWT", "encryption", "encrypt", "sign", "signature", "integrity", "identity", "assurance", "secure",  "cryptography", "symetric", "asymetric", "keys", "private key", "public key", "pkcs", "sec1", "pkcs8"]
updated = "2025-05-09"
[meta]
    title = "JWS & JWE Rust Libraries"
    description = "A rust implementation of the JWE and JWS Specification"
    author = "Shane Oatman"
+++

# Introduction

One of the first things that we want to do in terms of our backend services is to select and or build the correct security infrastructure.  We will start with the JSON Object Signing and Encryption suite of protocols.  In this case we plan to start by creating a JSON web signature and JSON web encryption libraries.  These libraries are use to authenticate and ensure the integrity of JSON messages.  The most common use of both JWS and JWE is in the support of JSON Web tokens, signing and/or validating them.

## Goals for Libraries

- Be up to date with the latests specs.
- Support both compact and JSON serialization.
- Identity alg/key type based on file contents.
- Support all optional, required and recommended algorthims from the [algorithms specification](https://www.iana.org/assignments/jose/jose.xhtml#web-signature-encryption-algorithms)
- Make it simple for developers to select the cryptography implementation of their choosing.  (Different folks will have different requirements; for example [US Federal Information Processing Standards (FIPS) compliance).](https://www.nist.gov/standardsgov/compliance-faqs-federal-information-processing-standards-fips).
- Make it simple for developers to sign and/or encrypt JSON payloads.
