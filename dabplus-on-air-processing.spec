
%define _gh_mk_lp_name mk_liquidsoap_processing
%define _gh_mk_lp_ref master
# liquidsoap version
%define _ls_version 1.2.1

Name:     dabplus-on-air-processing

Requires: liquidsoap
Requires: fdk-aac-dabplus-odr
Requires: %{_gh_mk_lp_name}

Version:  master
Release:  1
Summary:  Liquidsoap based DAB+ on air processing solution
License:  GPLv3+
URL:      https://github.com/radiorabe/dabplus-on-air-processing
Source0:  https://github.com/radiorabe/dabplus-on-air-processing/archive/%{version}.tar.gz#/%{name}-%{version}.tar.gz
Source1:  https://github.com/mkpascal/%{_gh_mk_lp_name}/archive/%{_gh_mk_lp_ref}.tar.gz#/%{_gh_mk_lp_name}-%{_gh_mk_lp_ref}.tar.gz
Patch0:   mk_liquidsoap_processing-input-variable.patch

%description
DAB+ on air processing is the precessing chain we use to prepare and encode the
broadcast signal for Radio Bern RaBe.

%package -n %{_gh_mk_lp_name}
Summary:  Broadcast Audio Processing Settings in Liquidsoap
Requires: %{name} = %{version}-%{release}
Requires: ladspa-tap-plugins
Requires: ladspa-swh-plugins

%description -n %{_gh_mk_lp_name}
Multiband compression chain for liquidsoap. Packaged as part of %{name}.

%prep
%setup0
%setup1 -T -D -a 1
cd %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}
%patch0 -p1

%install
install -d %{buildroot}/etc/liquidsoap
install src/dabplus-on-air-processing.liq %{buildroot}/etc/liquidsoap/
install dabplus-on-air-processing.conf %{buildroot}/etc/liquidsoap/
install -d %{buildroot}/usr/lib/liquidsoap/%{_ls_version}/
install %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/process.liq %{buildroot}/usr/lib/liquidsoap/%{_ls_version}/

%files
%doc README.md
%config /etc/liquidsoap/dabplus-on-air-processing.liq
%config /etc/liquidsoap/dabplus-on-air-processing.conf

%files -n %{_gh_mk_lp_name}
%doc %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/README.md
%doc %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/LICENSE
/usr/lib/liquidsoap/%{_ls_version}/process.liq
