<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  
  

  
<link rel="stylesheet" type="text/css" href="http://static.jquery.com/ui/css/trac.css" />
<link rel="stylesheet" href="http://static.jquery.com/ui/css/base2.css" type="text/css" media="screen" />


  

  <head>
    <title>
      /tags/1.5a/tablesorter/2.0/jquery.tablesorter.js –
      jQuery UI Development – Trac
    </title>
        <link rel="search" href="/search" />
        <link rel="help" href="/wiki/TracGuide" />
        <link rel="alternate" href="/browser/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js?rev=747&amp;format=txt" type="text/plain" title="Plain Text" /><link rel="alternate" href="/export/747/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js" type="text/x-javascript; charset=utf-8" title="Original Format" />
        <link rel="up" href="/browser/tags/1.5a/tablesorter/2.0?rev=747" title="Parent directory" />
        <link rel="start" href="/wiki" />
        <link rel="stylesheet" href="/chrome/common/css/trac.css" type="text/css" /><link rel="stylesheet" href="/chrome/common/css/code.css" type="text/css" /><link rel="stylesheet" href="/chrome/common/css/browser.css" type="text/css" />
        <link rel="shortcut icon" href="http://ui.jquery.com/images/favicon.ico" type="image/x-icon" />
        <link rel="icon" href="http://ui.jquery.com/images/favicon.ico" type="image/x-icon" />
      <link type="application/opensearchdescription+xml" rel="search" href="/search/opensearch" title="Search jQuery UI Development" />
    <script type="text/javascript" src="/chrome/common/js/jquery.js"></script><script type="text/javascript" src="/chrome/common/js/trac.js"></script><script type="text/javascript" src="/chrome/common/js/search.js"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" src="/chrome/common/js/ie_pre7_hacks.js"></script>
    <![endif]-->
    <script type="text/javascript">
      jQuery(document).ready(function($) {
        $("#jumploc input").hide();
        $("#jumploc select").change(function () {
          this.parentNode.parentNode.submit();
        })
      });
    </script>
</head>
  <body id="trac">
   <div id="wrapper">
	<div id="banner">
		<h1 class="logo">
			<a href="http://ui.jquery.com/home" title="jQuery UI"><span>jQuery UI</span></a>
		</h1>
		<div id="dock">
			<div class="left"></div>
			<ul>
				<li>
					<a href="http://jquery.com">jQuery</a>
				</li>
				<li style="padding-right: 12px;">
					<a href="http://plugins.jquery.com/">Plugins</a>
				</li>
				<li class="selected" style="padding-right: 12px;">
					<a href="http://jqueryui.com/home">UI</a>
				</li>
				<li style="padding-left: 12px;">
					<div style="background: #555; width: 1px; height: 24px; position: absolute; left: 0px;"></div>
					<a href="http://blog.jqueryui.com/">Blog</a>
				</li>
				<li>
					<a href="http://jqueryui.com/about">About</a>
				</li>
				<li>
					<a href="http://docs.jquery.com/Donate">Donate</a>
				</li>
			</ul>
			<div class="right"></div>
		</div>
		<div id="navigation">
			<div class="left"></div>
			<ul>
				<li>
					<a href="http://jqueryui.com/download">Download</a>
				</li>
				<li>
					<a href="http://jqueryui.com/demos">Demos &amp; Documentation</a>
				</li>
				<li>
					<a href="http://jqueryui.com/themeroller">Themes</a>
				</li>
				<li class="selected">
					<a href="http://jqueryui.com/development">Development</a>
				</li>
				<li class="last">
					<a href="http://jqueryui.com/support">Support</a>
				</li>
			</ul>
			<div class="right"></div>
		</div>
	</div>
	<div id="content-wrapper">
		<div id="content">
    <div id="banner">
      <div id="header">
        <h1><a href="">jQuery UI Development</a></h1>
      </div>
      <form id="search" action="/search" method="get">
        <div>
          <label for="proj-search">Search:</label>
          <input type="text" id="proj-search" name="q" size="18" value="" />
          <input type="submit" value="Search" />
        </div>
      </form>
      <div id="metanav" class="nav">
    <ul>
      <li class="first"><a href="/login">Login</a></li><li><a href="/prefs">Preferences</a></li><li><a href="/wiki/TracGuide">Help/Guide</a></li><li><a href="/about">About Trac</a></li><li class="last"><a href="/register">Register</a></li>
    </ul>
  </div>
    </div>
    <div id="mainnav" class="nav">
    <ul>
      <li class="first"><a href="/wiki">Wiki</a></li><li><a href="/timeline">Timeline</a></li><li><a href="/roadmap">Roadmap</a></li><li class="active"><a href="/browser">Browse Source</a></li><li><a href="/report">View Tickets</a></li><li class="last"><a href="/search">Search</a></li>
    </ul>
  </div>
    <div id="main">
      <div id="ctxtnav" class="nav">
        <h2>Context Navigation</h2>
          <ul>
            <li class="first "><a href="/changeset/12/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js">Last Change</a></li><li><a href="/browser/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js?annotate=blame&amp;rev=12" title="Annotate each line with the last changed revision (this can be time consuming...)">Annotate</a></li><li class="last"><a href="/log/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js?rev=747">Revision Log</a></li>
          </ul>
        <hr />
      </div>
    <div id="content" class="browser">
      <h1>
    <a class="pathentry first" title="Go to root directory" href="/browser?rev=747">root</a><span class="pathentry sep">/</span><a class="pathentry" title="View tags" href="/browser/tags?rev=747">tags</a><span class="pathentry sep">/</span><a class="pathentry" title="View 1.5a" href="/browser/tags/1.5a?rev=747">1.5a</a><span class="pathentry sep">/</span><a class="pathentry" title="View tablesorter" href="/browser/tags/1.5a/tablesorter?rev=747">tablesorter</a><span class="pathentry sep">/</span><a class="pathentry" title="View 2.0" href="/browser/tags/1.5a/tablesorter/2.0?rev=747">2.0</a><span class="pathentry sep">/</span><a class="pathentry" title="View jquery.tablesorter.js" href="/browser/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js?rev=747">jquery.tablesorter.js</a>
    <span class="pathentry sep">@</span>
      <a class="pathentry" href="/changeset/747" title="View changeset 747">747</a>
    <br style="clear: both" />
  </h1>
      <div id="jumprev">
        <form action="" method="get">
          <div>
            <label for="rev" title="Hint: clear the field to view latest revision">
              View revision:</label>
            <input type="text" id="rev" name="rev" value="747" size="6" />
          </div>
        </form>
      </div>
      <div id="jumploc">
        <form action="" method="get">
          <div class="buttons">
            <label for="preselected">Visit:</label>
            <select id="preselected" name="preselected">
              <option selected="selected"></option>
              <optgroup label="branches">
                <option value="/browser/trunk">trunk</option><option value="/browser/branches/dev">branches/dev</option><option value="/browser/branches/experimental">branches/experimental</option><option value="/browser/branches/labs">branches/labs</option>
              </optgroup><optgroup label="tags">
                <option value="/browser/tags/1.0?rev=747">tags/1.0</option><option value="/browser/tags/1.0.1a?rev=747">tags/1.0.1a</option><option value="/browser/tags/1.5?rev=747">tags/1.5</option><option value="/browser/tags/1.5.1?rev=747">tags/1.5.1</option><option value="/browser/tags/1.5.2?rev=747">tags/1.5.2</option><option value="/browser/tags/1.5.3?rev=2383">tags/1.5.3</option><option value="/browser/tags/1.5a?rev=747">tags/1.5a</option><option value="/browser/tags/1.5b?rev=747">tags/1.5b</option><option value="/browser/tags/1.5b2?rev=747">tags/1.5b2</option><option value="/browser/tags/1.5b3?rev=747">tags/1.5b3</option><option value="/browser/tags/1.5b4?rev=747">tags/1.5b4</option><option value="/browser/tags/1.5rc1?rev=747">tags/1.5rc1</option><option value="/browser/tags/1.6?rev=2465">tags/1.6</option><option value="/browser/tags/1.6b?rev=747">tags/1.6b</option><option value="/browser/tags/1.6rc1?rev=747">tags/1.6rc1</option><option value="/browser/tags/1.6rc2?rev=747">tags/1.6rc2</option><option value="/browser/tags/1.6rc2.5?rev=2289">tags/1.6rc2.5</option><option value="/browser/tags/1.6rc2.6?rev=2386">tags/1.6rc2.6</option><option value="/browser/tags/1.6rc3?rev=1444">tags/1.6rc3</option><option value="/browser/tags/1.6rc4?rev=1458">tags/1.6rc4</option><option value="/browser/tags/1.6rc5?rev=2023">tags/1.6rc5</option><option value="/browser/tags/1.6rc6?rev=2024">tags/1.6rc6</option><option value="/browser/tags/1.7?rev=2205">tags/1.7</option><option value="/browser/tags/1.7.1?rev=2337">tags/1.7.1</option><option value="/browser/tags/latest?rev=2339">tags/latest</option><option value="/browser/tags/legacy?rev=2467">tags/legacy</option><option value="/browser/tags/testing?rev=2340">tags/testing</option>
              </optgroup>
            </select>
            <input type="submit" value="Go!" title="Jump to the chosen preselected path" />
          </div>
        </form>
      </div>
      <table id="info" summary="Revision info">
        <tr>
          <th scope="col">
            Revision <a href="/changeset/12">12</a>, <span title="23897 bytes">23.3 kB</span>
            (checked in by rdworth, <a class="timeline" href="/timeline?from=2008-05-23T04%3A46%3A15Z-0700&amp;precision=second" title="2008-05-23T04:46:15Z-0700 in Timeline">11 months</a> ago)
          </th>
        </tr>
        <tr>
          <td class="message searchable">
              <p>
Added UI tags from jQuery svn<br />
</p>
          </td>
        </tr>
      </table>
      <div id="preview" class="searchable">
    <table class="code"><thead><tr><th class="lineno" title="Line numbers">Line</th><th class="content"> </th></tr></thead><tbody><tr><th id="L1"><a href="#L1">1</a></th><td>/*
      </div>
      <div id="help">
        <strong>Note:</strong> See <a href="/wiki/TracBrowser">TracBrowser</a>
        for help on using the browser.
      </div>
      <div id="anydiff">
        <form action="/diff" method="get">
          <div class="buttons">
            <input type="hidden" name="new_path" value="/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js" />
            <input type="hidden" name="old_path" value="/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js" />
            <input type="hidden" name="new_rev" value="12" />
            <input type="hidden" name="old_rev" value="12" />
            <input type="submit" value="View changes..." title="Select paths and revs for Diff" />
          </div>
        </form>
      </div>
    </div>
    <div id="altlinks">
      <h3>Download in other formats:</h3>
      <ul>
        <li class="first">
          <a rel="nofollow" href="/browser/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js?rev=747&amp;format=txt">Plain Text</a>
        </li><li class="last">
          <a rel="nofollow" href="/export/747/tags/1.5a/tablesorter/2.0/jquery.tablesorter.js">Original Format</a>
        </li>
      </ul>
    </div>
    </div>
    <div id="footer" lang="en" xml:lang="en"><hr />
      <a id="tracpowered" href="http://trac.edgewall.org/"><img src="/chrome/common/trac_logo_mini.png" height="30" width="107" alt="Trac Powered" /></a>
      <p class="left">
        Powered by <a href="/about"><strong>Trac 0.11.1</strong></a><br />
        By <a href="http://www.edgewall.org/">Edgewall Software</a>.
      </p>
      <p class="right"></p>
    </div>
		</div>
	</div>
	<div id="footer">
		<div class="bg"></div>
		<div class="inner">
			<p>
				<span class="first">Sponsored by: </span>
				<a href="http://www.filamentgroup.com" class="block filamentgroup"><span>Filamentgroup</span></a>
				<span style="float: right; padding-right: 12px;" class="first">© 2009 Paul Bakaus and the <a href="/about">jQuery UI Team</a>.</span>
			</p>
		</div>
	</div>
	</div>
</body>
</html>