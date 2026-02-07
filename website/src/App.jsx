import './App.css'

const GITHUB_REPO = 'https://github.com/hsavit1/SpeedTest'
const DOWNLOAD_URL = `${GITHUB_REPO}/releases/latest/download/SpeedTest-v1.1.0.dmg`
const INSTALL_CMD = 'curl -sL https://raw.githubusercontent.com/hsavit1/SpeedTest/main/install.sh | bash'

function App() {
  return (
    <div className="app">
      <Nav />
      <Hero />
      <Features />
      <HowItWorks />
      <Install />
      <Footer />
    </div>
  )
}

function Nav() {
  return (
    <nav className="nav">
      <div className="nav-inner">
        <a href="/" className="nav-brand">
          <GaugeIcon />
          <span>Speed Test</span>
        </a>
        <div className="nav-links">
          <a href="#features">Features</a>
          <a href="#install">Install</a>
          <a href={GITHUB_REPO} target="_blank" rel="noopener noreferrer">GitHub</a>
          <a href={DOWNLOAD_URL} className="nav-download">Download</a>
        </div>
      </div>
    </nav>
  )
}

function Hero() {
  return (
    <section className="hero">
      <div className="hero-glow" />
      <div className="hero-content">
        <div className="hero-badge">macOS 14+ Widget</div>
        <h1>
          Test your internet speed<br />
          <span className="gradient-text">right from your desktop.</span>
        </h1>
        <p className="hero-subtitle">
          A native macOS widget that measures download speed with a single tap.
          No browser needed. No ads. Open source.
        </p>
        <div className="hero-actions">
          <a href={DOWNLOAD_URL} className="btn btn-primary">
            <DownloadIcon />
            Download for Mac
          </a>
          <a href={GITHUB_REPO} className="btn btn-secondary" target="_blank" rel="noopener noreferrer">
            <GitHubIcon />
            View Source
          </a>
        </div>
        <p className="hero-note">Requires macOS 14 Sonoma or later</p>
      </div>
      <div className="hero-visual">
        <WidgetPreview />
      </div>
    </section>
  )
}

function WidgetPreview() {
  return (
    <div className="widget-frame">
      <div className="widget">
        <div className="widget-speed">
          <span className="widget-number">248</span>
          <span className="widget-unit">Mbps</span>
        </div>
        <div className="widget-time">2 min ago</div>
        <button className="widget-btn">
          <BoltIcon />
          Test Speed
        </button>
      </div>
    </div>
  )
}

function Features() {
  const features = [
    {
      icon: <BoltIcon />,
      title: 'One-Tap Testing',
      description: 'Hit the button right from Notification Center or your desktop. No app launch required.',
    },
    {
      icon: <ShieldIcon />,
      title: 'Private & Ad-Free',
      description: 'No tracking, no accounts, no ads. Your speed data stays on your device via App Groups.',
    },
    {
      icon: <GlobeIcon />,
      title: 'Cloudflare CDN',
      description: 'Downloads from Cloudflare\'s global edge network for accurate, consistent results worldwide.',
    },
    {
      icon: <ChartIcon />,
      title: 'Adaptive Algorithm',
      description: 'Progressive chunk sizes from 100KB to 25MB with weighted averaging for precise measurements.',
    },
    {
      icon: <CodeIcon />,
      title: 'Open Source',
      description: 'MIT licensed. Read the code, contribute, or fork it. Built with SwiftUI and WidgetKit.',
    },
    {
      icon: <CpuIcon />,
      title: 'Native Performance',
      description: 'Pure Swift with zero dependencies. Lightweight, fast, and built specifically for macOS.',
    },
  ]

  return (
    <section id="features" className="features">
      <div className="section-inner">
        <h2>Why Speed Test?</h2>
        <p className="section-subtitle">
          Fast, private, and always one tap away.
        </p>
        <div className="features-grid">
          {features.map((f) => (
            <div className="feature-card" key={f.title}>
              <div className="feature-icon">{f.icon}</div>
              <h3>{f.title}</h3>
              <p>{f.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}

function HowItWorks() {
  const steps = [
    { num: '1', title: 'Run the installer', desc: 'Paste the install command below into Terminal. It downloads, installs, and opens the app.' },
    { num: '2', title: 'Add the widget', desc: 'Click the date/time in your menu bar → scroll down → "Edit Widgets" → add Speed Test.' },
    { num: '3', title: 'Tap to test', desc: 'Hit "Test Speed" on the widget anytime to measure your download speed.' },
  ]

  return (
    <section className="how-it-works">
      <div className="section-inner">
        <h2>Get started in seconds</h2>
        <p className="section-subtitle">Three steps. No account needed.</p>
        <div className="steps">
          {steps.map((s) => (
            <div className="step" key={s.num}>
              <div className="step-num">{s.num}</div>
              <div className="step-content">
                <h3>{s.title}</h3>
                <p>{s.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}

function Install() {
  return (
    <section id="install" className="install">
      <div className="section-inner">
        <div className="install-card">
          <h2>Ready to test your speed?</h2>
          <p>Download the app and add the widget to your desktop in under a minute.</p>
          <p className="install-label">Run this in Terminal:</p>
          <code className="install-code">
            {INSTALL_CMD}
          </code>
          <div className="install-actions">
            <a href={DOWNLOAD_URL} className="btn btn-secondary">
              <DownloadIcon />
              Or download the .dmg manually
            </a>
          </div>
        </div>
      </div>
    </section>
  )
}

function Footer() {
  return (
    <footer className="footer">
      <div className="footer-inner">
        <div className="footer-brand">
          <GaugeIcon />
          <span>Speed Test</span>
        </div>
        <p className="footer-copy">
          Open source under MIT. Built with SwiftUI & WidgetKit.
        </p>
        <div className="footer-links">
          <a href={GITHUB_REPO} target="_blank" rel="noopener noreferrer">GitHub</a>
          <a href={`${GITHUB_REPO}/issues`} target="_blank" rel="noopener noreferrer">Issues</a>
          <a href={DOWNLOAD_URL} target="_blank" rel="noopener noreferrer">Releases</a>
        </div>
      </div>
    </footer>
  )
}

/* Icons */
function GaugeIcon() {
  return (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 16.5V9.5" /><path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z" />
      <path d="m4.93 4.93 2.83 2.83" />
    </svg>
  )
}

function DownloadIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/>
    </svg>
  )
}

function GitHubIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
      <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0 0 24 12c0-6.63-5.37-12-12-12z"/>
    </svg>
  )
}

function BoltIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
    </svg>
  )
}

function ShieldIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
    </svg>
  )
}

function GlobeIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10A15.3 15.3 0 0 1 12 2z"/>
    </svg>
  )
}

function ChartIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/>
    </svg>
  )
}

function CodeIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/>
    </svg>
  )
}

function CpuIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="4" y="4" width="16" height="16" rx="2" ry="2"/><rect x="9" y="9" width="6" height="6"/><line x1="9" y1="1" x2="9" y2="4"/><line x1="15" y1="1" x2="15" y2="4"/><line x1="9" y1="20" x2="9" y2="23"/><line x1="15" y1="20" x2="15" y2="23"/><line x1="20" y1="9" x2="23" y2="9"/><line x1="20" y1="14" x2="23" y2="14"/><line x1="1" y1="9" x2="4" y2="9"/><line x1="1" y1="14" x2="4" y2="14"/>
    </svg>
  )
}

export default App
