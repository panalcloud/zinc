I wake a Server-Sent Events handler when there is something to send. Any process can #ring me, any number of times; the handler waits with #waitAtMost: (or through ZnServerSentEventStream>>#waitFor:keepAliveEvery:).

No ring is lost: a ring while nobody waits makes the next wait return at once. Many rings before a wait give one wake. The rule for users: post the work first, then ring; after a wait, take all posted work.

  bell := ZnServerSentEventDoorbell new.
  "producer" queue nextPut: item. bell ring.
  "handler" [ stream waitFor: bell keepAliveEvery: 20 seconds ] whileTrue: [ queue ... send ... ]

I am a semaphore whose extra signals are dropped after each wait.

Part of Zinc HTTP Components.