all: ;

clean:
	/bin/rm ${DESTDIR}/etc/apt/trusted.gpg.d/repos.kbaranski.pl.gpg   || true
	/bin/rm ${DESTDIR}/etc/apt/sources.list.d/repos.kbaranski.pl.list || true

install:
	/usr/bin/install -m 644 -D repos.kbaranski.pl.gpg  ${DESTDIR}/etc/apt/trusted.gpg.d/repos.kbaranski.pl.gpg
	/usr/bin/install -m 644 -D repos.kbaranski.pl.list ${DESTDIR}/etc/apt/sources.list.d/repos.kbaranski.pl.list

package:
	LC_ALL=C debuild -us -uc
