# Using BSD Owl on Cygwin

On UNIX systems it is traditional *not to use* spaces in file names or
system identifiers such as user names or group names. Not only bsdowl
but also various versions of make, including BSD Make, were written
with this tradition in mind, and it is illusory to adapt these tools
to work correctly on a Cygwin environment where groups identifiers
like `Domain Users` exist or directories like `Program Files (x86)`
are part of the path.

We can however try to sanitize the Cygwin environment by doing the
following arrangements:

1. Use the `id` command to determine your `uid` and your `gid`.
2. Determine a sanitized path like deduced from your actual PATH by removing
   elements having a space in their name.
3. Set `USE_SWITCH_CREDENTIALS=no` to avoid using `su` to gain root credentials.

For 2. we may start with `/usr/local/bin:/usr/bin` and add further
path elements as needed.  See also below *Dealing with Program Files*
to add path elements under `Program Files` and `Program Files (x86)`
to your path.

We can define an alias in our `~/.profile` to put these setting at our
fingertips, such as:

    alias bmake='env USE_SWITCH_CREDENTIALS=no USER=500 GROUP=500 PATH=/usr/local/bin:/usr/bin /usr/local/bin/bmake'

Adapt the numerical values for USER and GROUP to reflect your actual
`uid` and `gid` as reported by the `id` program. Adapt the PATH and
the path to the actual `bmake` program as required.


## Dealing with Program Files

Assume your PATH contains the following items:

    /usr/local/bin
    /usr/bin
    /cygdrive/c/Windows/System32
    /cygdrive/c/Windows/System32/Wbem
    /usr/local/texlive/2014/bin/i386-cygwin
    /cygdrive/c/Program Files/TortoiseGit/bin
    /cygdrive/c/Program Files (x86)/GitExtensions
    /cygdrive/c/Program Files (x86)/Java/jre7/bin
    /usr/lib/lapack

The two items

    /cygdrive/c/Program Files (x86)/GitExtensions
    /cygdrive/c/Program Files (x86)/Java/jre7/bin

are problematic because of the whitespaces they contain. We can use
symbolic links to safely add these paths to our PATH:

    mkdir /opt
    ln -s "/cygdrive/c/Program Files (x86)/GitExtensions" /opt/GitExtensions
    ln -s "/cygdrive/c/Program Files (x86)/Java/jre7" /opt/jre7

After this setup, we can use the following alias to start bmake in a
safe setting:

    alias bmake='env USE_SWITCH_CREDENTIALS=no USER=500 GROUP=500 PATH=/usr/local/bin:/usr/bin:/cygdrive/c/Windows/System32:/cygdrive/c/Windows/System32/Wbem:/usr/local/texlive/2014/bin/i386-cygwin:/cygdrive/c/Program Files/TortoiseGit/bin:/opt/GitExtensions:/opt/jre7/bin:/usr/lib/lapack /usr/local/bin/bmake'
