# Synopsis

Scisco is a privacy-preserving, auditable, distributed voting system.

# Motivation

The current standard mechanisms of conducting voting-based elections are profoundly inadequate. Most are technologically fragmented ([1](https://www.eac.gov/voting-equipment/managing-election-technology/)), reliant on fallible ([2](https://www.theguardian.com/technology/2017/jun/05/russia-us-election-hack-voting-system-nsa-report)) and often misincentivized trusted third parties, difficult and time-consuming to audit ([3](https://www.verifiedvoting.org/resources/post-election-audits/)), and woefully insecure against numerous attack vectors ([4](https://www.bloomberg.com/news/articles/2017-06-13/russian-breach-of-39-states-threatens-future-u-s-elections)).

An ideal system would simultaneously provide both privacy and auditability: no participant (including the identity provider / government) would be able to determine which voter voted for which candidate, but anyone could easily verify the integrity of the process and correctness of the final vote tallies.

Scisco is a proof-of-concept implementation designed to demonstrate how such a system might work.

As implemented, Scisco provides both privacy and auditability as following:

- Each voter in an election can cast their vote without any other participant, including the identity provider, being able to determine for whom they voted.
- All participants in an election (indeed, anyone with an internet connection and a modern computer) can independently verify that the election was conducted fairly - all registered participants were given the opportunity to vote, no votes were falsified or duplicated, and the final reported tallies were accurate.

To accomplish this, Scisco makes use of the [Tendermint](https://tendermint.com/) BFT state machine replication system / [ABCI](https://github.com/tendermint/abci) blockchain abstraction layer along with [linkable ring signatures](https://link.springer.com/chapter/10.1007%2F11424826_65#page-1) to provide the desired security properties.

# Disclaimer

This is experimental software, written quickly as a demonstrative proof-of-concept for a hackathon, and has not been formally verified or subjected to professional review. It may be vulnerable to unforeseen theoretical and implementation-specific attacks. Use at your own risk.

# Demonstration

The easiest way to test Scisco is by starting a local testnet, on which you may view, start, and participate in elections.

Simply download the [autobuilt Docker image](https://hub.docker.com/r/cgoes/scisco):

```
docker run -d --net=host cgoes/scisco
```

Launching Scisco and Tendermint should take about fifteen seconds. After completion, open your web browser to [http://localhost:3000](http://localhost:3000) and play around!

# Implementation Overview

Scisco implements the abstraction of an *election* - the blockchain can support an arbitrary number of elections, each of which must be referenced by a unique identifier.

Each election proceeds in the following steps, which must be completed in order:

1. An authority, identified by a public key with which they can sign messages, initiates the election, specifying a unique identifier.

   It is the job of this authority to validate identities - of voters and candidates. This role is usually played by the government (or agents acting on its behalf) in modern elections; however, it could also be done with a separate on-chain identity verification system.
   The *only* special authorization (and responsibility) given to this authority is identity validation of candidates and voters - the authority possesses no more information about voters or votes than any other network participant.

2. Voters and candidates register for the election. (Stage: _Registration_, lasting a set number of blocks)

   Voters must specify an identifier, public key, and second special public key utilized for ring signatures. Candidates must specify an identifier and public key.
   This identifier is arbitrary - it could be, for example, a name, which the authority could verify against the public key in an out-of-band fashion, a secret proof-of-identity (e.g. SSN signed with the voter's public key) encrypted with the authority's public key, or a reference to a separate database altogether.
   The authority must accept or reject voters and candidates, and it does so publicly, providing a reason for rejection when a voter or candidate is rejected for a later audit if desired. 

3. Approved voters cast votes for approved candidates. (Stage: _Voting_, lasting a set number of blocks)

   Voters *anonymously* cast their ballots for the candidates for whom they wish to vote. When casting a ballot, a voter proves, using a ring signature, that they were an approved voter.
   The anonymity set of the ring signature is the entire set of approved voters - so no voter can be connected to their vote.
   Linkable ring signatures are utilized to prevent duplicate votes (the same voter voting twice): any two signatures signed by the same private key are identifiable as such (without identifying which public key the private key was associated with).

4. The election is complete, all final tallies are public. No more actions may be taken by any party. All election history - registrations of voters and candidates, approvals/rejections by the identification authority, cast ballots, and final vote tallies - is recorded on the blockchain and auditable by anyone.

# Known Issues

- No incentivization mechanism currently exists for validators. This could be fixed by associating the Scisco blockchain with a token and utilizing proof-of-stake, with some nominal transaction cost required to register for elections and cast votes which is then collected by validators.
  Alternatively, the election system demonstrated by Scisco could be implemented on top of a sufficiently computationally capable blockchain - Ethereum should be capable, although ring signatures might be expensive on the EVM; upcoming Tezos might also be a candidate.

# Future Directions

- Mobile Port

  Particular difficulties of cross-compiling Haskell aside, mobile devices should be computationally capable of running Scisco, validating elections, and providing a user-friendly voting interface through an easy-to-use app. Such as system, used in production, would substantially decrease the barrier-to-entry required for voting as compared to the physical polling or even mail-in ballots currently standard in most of the world.

- zkSNARK vote verification

  zkSNARKs (utilized notably in Zcash) could provide the same security properties and support various kinds of voting systems, such as ones where different participants have different voting weights, non first-past-the-post candidate election mechanisms, etc. Current implementations would likely perform poorly compared to ring signatures for low voter-count elections, but comparably quickly for larger ones (zkSNARKs should be approximately constant in space and time complexity, whereas the linked ring signature implementation currently used is O(n)). They would have the additional disadvantage of requiring a trusted setup, although there might be ways to implement that (perhaps on the blockchain) that would substantially mitigate the risk.
